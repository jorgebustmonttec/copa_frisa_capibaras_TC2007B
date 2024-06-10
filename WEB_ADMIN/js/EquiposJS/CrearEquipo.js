const apiUrl = 'https://localhost:3443';

    async function createEquipo(event) {
        event.preventDefault();
        try {
            const form = document.getElementById('create-equipo-form');
            const formData = new FormData(form);

            const response = await fetch(`${apiUrl}/equipos/create`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    nombre_equipo: formData.get('nombre_equipo'),
                    escuela: formData.get('escuela')
                })
            });

            if (!response.ok) throw new Error('Error al crear el equipo');
            const result = await response.json();
            const id = result.id_equipo;

            const escudoFormData = new FormData();
            escudoFormData.append('escudo', formData.get('escudo'));

            const escudoResponse = await fetch(`${apiUrl}/equipos/create/${id}/escudo`, {
                method: 'POST',
                body: escudoFormData
            });

            if (!escudoResponse.ok) throw new Error('Error al subir el escudo');

            alert('Equipo creado exitosamente');
            form.reset(); // Limpia el formulario después de la creación exitosa
            
            // Redirección a la vista de Equipos
            window.location.href = 'Equipos.html'; // Asegúrate de que la URL es correcta para la vista de Equipos

        } catch (error) {
            console.error('Error:', error);
            alert('Hubo un error al crear el equipo. Verifique los datos e intente nuevamente.');
        }
    }