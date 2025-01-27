<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Histogramme des Recettes par Province</title>

    <!-- Chargement de Google Charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart', 'bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Province', 'Recettes (en millions)'],
          ['Province 1', 150],
          ['Province 2', 200],
          ['Province 3', 250],
          ['Province 4', 180],
          ['Province 5', 220],
          ['Province 6', 300],
          ['Province 7', 275],
          ['Province 8', 320],
          ['Province 9', 350],
          ['Province 10', 280],
          ['Province 11', 210],
          ['Province 12', 190],
          ['Province 13', 330],
          ['Province 14', 300],
          ['Province 15', 400],
          ['Province 16', 270],
          ['Province 17', 230],
          ['Province 18', 350],
          ['Province 19', 310],
          ['Province 20', 360],
          ['Province 21', 290],
          ['Province 22', 330],
          ['Province 23', 350],
          ['Province 24', 375],
          ['Province 25', 380],
          ['Province 26', 420]
        ]);

        var options = {
          title: 'Recettes des Provinces',
          chartArea: {width: '60%', height: '70%'},
          hAxis: {
            title: 'Provinces',
            minValue: 0
          },
          vAxis: {
            title: 'Recettes (en millions)',
            gridlines: {count: 5}
          },
          colors: ['#4CAF50'],
          bar: {groupWidth: '85%'}, // Largeur des barres
          legend: { position: 'none' }
        };

        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <h1>Histogramme des Recettes par Province</h1>
    <div id="chart_div" style="width: 100%; height: 600px;"></div>
  </body>
</html>
