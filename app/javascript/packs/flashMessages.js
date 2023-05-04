import Toastify from "toastify-js"

document.addEventListener("DOMContentLoaded", () => {
    const backgroudColors = {
        alert: "red",
        error: "red",
        notice: "green"
    }

    JSON.parse(document.body.dataset.flashMessages).forEach(flashMessage => {
        const [type, message] = flashMessage;

        Toastify({
            text: message,
            duration: 3000,
            close: true,
            backgroundColor: backgroudColors[type],
            stopOnFocus: true
        }).showToast();
    });
});