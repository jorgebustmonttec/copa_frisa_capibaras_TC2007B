const apiUrl = 'https://localhost:3443';
const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get('id');
let post = {}; // To store the original post data
let uploadedImage = false; // To track if a new image is uploaded

document.addEventListener('DOMContentLoaded', async () => {
    await fetchPost(); // Asegura que fetchPost se complete antes de añadir el manejador de evento.
    const form = document.getElementById('edit-post-form');
    form.onsubmit = updatePost; // Asigna directamente el manejador al evento onsubmit.
});

async function fetchPost() {
    try {
        const response = await fetch(`${apiUrl}/publicaciones/${id}`);
        if (!response.ok) throw new Error('Error al obtener la publicación');
        post = await response.json();

        document.getElementById('titulo').value = post.titulo;
        document.getElementById('contenido').value = post.contenido;
        document.getElementById('titulo').placeholder = post.titulo;
        document.getElementById('contenido').placeholder = post.contenido;

        const imagenResponse = await fetch(`${apiUrl}/publicaciones/${id}/imagen`);
        if (imagenResponse.ok) {
            const imagenBlob = await imagenResponse.blob();
            document.getElementById('current-imagen').src = URL.createObjectURL(imagenBlob);
        }

        document.getElementById('titulo').addEventListener('input', handleInputChange);
        document.getElementById('contenido').addEventListener('input', handleInputChange);
        document.getElementById('imagen').addEventListener('change', handleInputChange);
    } catch (error) {
        console.error('Error:', error);
    }
}

function handleInputChange() {
    const titulo = document.getElementById('titulo').value;
    const contenido = document.getElementById('contenido').value;
    const imagen = document.getElementById('imagen').files.length > 0;

    const updateButton = document.getElementById('update-button');
    uploadedImage = imagen; // Track if a new image is uploaded

    if (titulo !== post.titulo || contenido !== post.contenido || imagen) {
        updateButton.classList.remove('disabled');
        updateButton.disabled = false;
    } else {
        updateButton.classList.add('disabled');
        updateButton.disabled = true;
    }
}

function removeUploadedImage() {
    document.getElementById('imagen').value = null;
    document.getElementById('current-imagen').src = "";
    uploadedImage = false;
    handleInputChange();
}

async function updatePost(event) {
    event.preventDefault(); // Detiene la propagación del evento y evita el comportamiento por defecto (envío del formulario).
    try {
        const titulo = document.getElementById('titulo').value.trim() || post.titulo;
        const contenido = document.getElementById('contenido').value.trim() || post.contenido;

        const payload = {
            titulo,
            contenido
        };
        const response = await fetch(`${apiUrl}/publicaciones/actualizar/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(payload)
        });

        if (!response.ok) throw new Error('Error al actualizar la publicación');

        if (uploadedImage) {
            const imagenFormData = new FormData();
            imagenFormData.append('imagen', document.getElementById('imagen').files[0]);
            const imagenResponse = await fetch(`${apiUrl}/publicaciones/${id}/imagen`, {
                method: 'POST',
                body: imagenFormData
            });

            if (!imagenResponse.ok) throw new Error('Error al actualizar la imagen');
        }

        alert('Publicación actualizada exitosamente');
        window.location.href = 'Publicaciones.html';
    } catch (error) {
        console.error('Error:', error);
    }
}

function goBack() {
    window.location.href = 'Publicaciones.html';
}
