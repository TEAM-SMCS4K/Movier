document.addEventListener("DOMContentLoaded", function() {
    const logo = document.getElementById("navi-logo");
    const originalLogoSrc = "../img/movier_white_logo.svg";
    const scrolledLogoSrc = "../img/navi_movier_logo"; // Replace with the actual path to the new logo

    window.addEventListener("scroll", function() {
        if (window.scrollY > 50) { // Change 50 to the desired scroll position threshold
            logo.src = scrolledLogoSrc;
        } else {
            logo.src = originalLogoSrc;
        }
    });
});
