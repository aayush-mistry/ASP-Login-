// Utility function to toggle password visibility
function togglePasswordVisibility(inputId, toggleBtnId) {
    var input = document.getElementById(inputId);
    var toggleBtn = document.getElementById(toggleBtnId);

    if (input && toggleBtn) {
        if (input.type === 'password') {
            input.type = 'text';
            toggleBtn.textContent = 'Hide'; // Hide icon
        } else {
            input.type = 'password';
            toggleBtn.textContent = 'Show'; // Show icon
        }
    }
}
