// sessionManagement.js
document.addEventListener('DOMContentLoaded', function() {
    if (!location.href.includes('loginAdmin.html')) {
        checkSession();
    }
});

function checkSession() {
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    if (isLoggedIn !== 'true') {
        window.location.href = 'loginAdmin.html'; // Redirigir si no está logueado
    }
}

function logout() {
    localStorage.setItem('isLoggedIn', 'false');
    localStorage.removeItem('id_usuario');
    localStorage.removeItem('tipo_usuario');
    window.location.href = 'loginAdmin.html';
}
