

const apiUrl = 'https://localhost:3443';

async function fetchPosts() {
    try {
        const response = await fetch(`${apiUrl}/publicaciones`);
        if (!response.ok) throw new Error('Error al obtener las publicaciones');
        const publicaciones = await response.json();

        const container = document.getElementById('publicaciones-container');
        container.innerHTML = ''; // Limpiar el contenido existente

        for (const publicacion of publicaciones) {
            const imagenUrl = `${apiUrl}/publicaciones/${publicacion.id_post}/imagen`; // Ruta para obtener la imagen

            const cardHTML = `
                <div class="mdl-cell mdl-cell--4-col-desktop mdl-cell--4-col-tablet mdl-cell--12-col-phone">
                    <div class="mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title">
                            <h2 class="mdl-card__title-text">${publicacion.titulo}</h2>
                        </div>
                        <div class="mdl-card__supporting-text">
                            Autor: ${publicacion.autor}<br>
                            Fecha: ${new Date(publicacion.fecha).toLocaleDateString()}<br>
                            <p>${publicacion.contenido}</p>
                            <img src="${imagenUrl}" alt="Publicación Imagen" style="width:100%; max-height:200px; object-fit: cover;">
                            <button onclick="editPost(${publicacion.id_post})" class="mdl-button mdl-js-button mdl-button--primary">Editar</button>
                            <button onclick="deletePost(${publicacion.id_post})" class="mdl-button mdl-js-button mdl-button--accent">Eliminar</button>
                        </div>
                    </div>
                </div>
            `;
            container.insertAdjacentHTML('beforeend', cardHTML);
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

function editPost(id) {
    window.location.href = `EditarPublicacion.html?id=${id}`;
}

async function deletePost(id) {
    if (!confirm('¿Estás seguro de que deseas eliminar esta publicación?')) return;
    try {
        const response = await fetch(`${apiUrl}/publicaciones/eliminar/${id}`, {
            method: 'DELETE'
        });
        if (!response.ok) throw new Error('Error al eliminar la publicación');
        alert('Publicación eliminada exitosamente');
        fetchPosts(); // Recargar publicaciones
    } catch (error) {
        console.error('Error:', error);
    }
}

document.addEventListener('DOMContentLoaded', fetchPosts);

