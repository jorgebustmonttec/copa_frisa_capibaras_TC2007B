const apiUrl = 'https://localhost:3443';
const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get('id');

document.addEventListener('DOMContentLoaded', async () => {
    await fetchPost();
    const form = document.getElementById('edit-post-form');
    form.addEventListener('submit', updatePost);
});

async function fetchPost() {
    try {
        const response = await fetch(`${apiUrl}/publicaciones/${id}`);
        if (!response.ok) throw new Error('Error al obtener la publicación');
        const post = await response.json();

        document.getElementById('titulo').value = post.titulo;
        document.getElementById('contenido').value = post.contenido;

        const imagenResponse = await fetch(`${apiUrl}/publicaciones/${id}/imagen`);
        if (imagenResponse.ok) {
            const imagenBlob = await imagenResponse.blob();
            document.getElementById('current-imagen').src = URL.createObjectURL(imagenBlob);
        }

        document.getElementById('titulo').addEventListener('input', enableUpdateButton);
        document.getElementById('contenido').addEventListener('input', enableUpdateButton);
        document.getElementById('imagen').addEventListener('change', enableUpdateButton);
    } catch (error) {
        console.error('Error:', error);
    }
}

function enableUpdateButton() {
    document.getElementById('update-button').disabled = false;
}

function removeUploadedImage() {
    document.getElementById('imagen').value = "";
    document.getElementById('current-imagen').src = "";
    enableUpdateButton();
}

async function updatePost(event) {
    event.preventDefault();
    try {
        const titulo = document.getElementById('titulo').value;
        const contenido = document.getElementById('contenido').value;
        const formData = new FormData();
        formData.append('titulo', titulo);
        formData.append('contenido', contenido);
        formData.append('imagen', document.getElementById('imagen').files[0]);

        const response = await fetch(`${apiUrl}/publicaciones/actualizar/${id}`, {
            method: 'PUT',
            body: formData
        });

        if (!response.ok) throw new Error('Error al actualizar la publicación');
        alert('Publicación actualizada exitosamente');
        window.location.href = 'Publicaciones.html';
    } catch (error) {
        console.error('Error:', error);
    }
}

function goBack() {
    window.location.href = 'Publicaciones.html';
}
