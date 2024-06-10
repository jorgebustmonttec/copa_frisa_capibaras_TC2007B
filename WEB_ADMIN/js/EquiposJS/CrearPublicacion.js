const apiUrl = 'https://localhost:3443';

async function createPost(event) {
    event.preventDefault();
    try {
        const form = document.getElementById('create-post-form');
        const formData = new FormData(form);

        const response = await fetch(`${apiUrl}/publicaciones/crear`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                autor: formData.get('autor'),
                titulo: formData.get('titulo'),
                contenido: formData.get('contenido')
            })
        });

        if (!response.ok) throw new Error('Error al crear la publicación');
        const result = await response.json();
        const id = result.id_post;

        // Ahora subir la imagen
        const imagenFormData = new FormData();
        imagenFormData.append('imagen', formData.get('imagen'));

        const imagenResponse = await fetch(`${apiUrl}/publicaciones/${id}/imagen`, {
            method: 'POST',
            body: imagenFormData
        });

        if (!imagenResponse.ok) throw new Error('Error al subir la imagen');
        alert('Publicación creada exitosamente');
        window.location.href = 'Publicaciones.html';  // Redirigir al usuario a la vista de publicaciones

    } catch (error) {
        console.error('Error:', error);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('create-post-form');
    form.addEventListener('submit', createPost);
});
