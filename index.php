<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>COTESFIP</title>
</head>
<style>
/* Réinitialisation de base */
body {
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f5f5f5;
    font-family: Arial, sans-serif;
}

/* Conteneur principal des logos */
.logo-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 20px; /* Espace entre les logos */
    padding: 20px;
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

/* Style des logos */
.logo {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background-size: cover;
    background-position: center;
}

/* Images spécifiques pour chaque logo */
#logo1 {
    background-image: url('images/Logodgi.png'); /* Remplace par le chemin de ton premier logo */
}

#logo2 {
    background-image: url('images/Logo-dgda.png'); /* Remplace par le chemin de ton deuxième logo */
}

#logo3 {
    background-image: url('images/logo-dgrad.png'); /* Remplace par le chemin de ton troisième logo */
}

</style>

<body>
    <div class="logo-container">
        <a href="dgi/"><div class="logo" id="logo1"></div></a>
        <a href="dgda/"><div class="logo" id="logo2"></div></a>
        <a href="dgrad"><div class="logo" id="logo3"></div></a>
    </div>
</body>

</html>