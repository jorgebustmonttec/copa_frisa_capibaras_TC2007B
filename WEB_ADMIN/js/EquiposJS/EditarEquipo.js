const apiUrl = 'https://localhost:3443';
        const urlParams = new URLSearchParams(window.location.search);
        const id = urlParams.get('id');
        let equipo = {}; // To store the original team data
        let uploadedImage = false; // To track if a new image is uploaded

        document.getElementById('id_equipo').value = id;

        async function fetchEquipo() {
            try {
                const response = await fetch(`${apiUrl}/equipos/single/${id}`);
                if (!response.ok) throw new Error('Error al obtener el equipo');
                equipo = await response.json();

                document.getElementById('nombre_equipo').placeholder = equipo.nombre_equipo;
                document.getElementById('escuela').placeholder = equipo.escuela;

                const escudoResponse = await fetch(`${apiUrl}/equipos/single/${id}/escudo`);
                if (escudoResponse.ok) {
                    const escudoBlob = await escudoResponse.blob();
                    const escudoUrl = URL.createObjectURL(escudoBlob);
                    document.getElementById('current-escudo').src = escudoUrl;
                }

                document.getElementById('nombre_equipo').addEventListener('input', handleInputChange);
                document.getElementById('escuela').addEventListener('input', handleInputChange);
                document.getElementById('escudo').addEventListener('change', handleInputChange);
            } catch (error) {
                console.error('Error:', error);
            }
        }

        function handleInputChange() {
            const nombre_equipo = document.getElementById('nombre_equipo').value;
            const escuela = document.getElementById('escuela').value;
            const escudo = document.getElementById('escudo').files.length > 0;

            const updateButton = document.getElementById('update-button');
            uploadedImage = escudo; // Track if a new image is uploaded

            if (nombre_equipo || escuela || escudo) {
                updateButton.classList.remove('disabled');
                updateButton.disabled = false;
            } else {
                updateButton.classList.add('disabled');
                updateButton.disabled = true;
            }
        }

        function removeUploadedImage() {
            document.getElementById('escudo').value = null;
            uploadedImage = false;
            handleInputChange();
        }

        async function updateEquipo(event) {
            event.preventDefault();
            try {
                const nombre_equipo = document.getElementById('nombre_equipo').value || equipo.nombre_equipo;
                const escuela = document.getElementById('escuela').value || equipo.escuela;

                const response = await fetch(`${apiUrl}/equipos/update/${id}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        nombre_equipo,
                        escuela
                    })
                });

                if (!response.ok) throw new Error('Error al actualizar el equipo');

                if (uploadedImage) {
                    const escudoFormData = new FormData();
                    escudoFormData.append('escudo', document.getElementById('escudo').files[0]);

                    const escudoResponse = await fetch(`${apiUrl}/equipos/create/${id}/escudo`, {
                        method: 'POST',
                        body: escudoFormData
                    });

                    if (!escudoResponse.ok) throw new Error('Error al actualizar el escudo');
                }

                alert('Equipo actualizado exitosamente');
                window.location.href = 'Equipos.html';
            } catch (error) {
                console.error('Error:', error);
            }
        }

        function goBack() {
            window.location.href = 'Equipos.html';
        }

        document.addEventListener('DOMContentLoaded', fetchEquipo);