function GenerateChart(jsonString) {
    console.log('Received data:', jsonString);
    
    try {
        const questions = typeof jsonString === 'string' ? JSON.parse(jsonString) : jsonString;
        console.log('Parsed questions:', questions);
        
        if (!Array.isArray(questions)) {
            console.error('Invalid data format - expected an array');
            return;
        }

        // Clear existing charts first
        const container = document.getElementById('controlAddIn');
        if (container) {
            container.innerHTML = '';
        }

        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(() => drawCharts(questions));
    } catch (error) {
        console.error('Error processing data:', error);
    }
}

function drawCharts(questions) {
    console.log('Drawing charts with data:', questions);
    
    const container = document.getElementById('controlAddIn');
    if (!container) {
        console.error('Container element "controlAddIn" not found!');
        return;
    }

    // Set container style for scrollable layout
    const heading = document.createElement('h2');
    heading.style.textAlign = 'center';
    heading.style.textDecoration = 'underline';
    heading.style.textTransform = 'uppercase';
    heading.textContent = 'SURVEY ANALYSIS';
    container.appendChild(heading);

    container.style.display = 'block';
    container.style.overflowY = 'auto';
    container.style.overflowX = 'hidden';
    container.style.padding = '20px';
    container.style.height = '100%';
    container.style.boxSizing = 'border-box';

    questions.forEach((question, index) => {
        console.log(`Processing question ${index}:`, question);
        
        const chartContainer = document.createElement('div');
        const title = document.createElement('h2');
        title.style.textAlign = 'center';
        title.style.fontSize = '2em';
        chartContainer.appendChild(title);
        chartContainer.style.width = '100%';
        chartContainer.style.marginBottom = '40px';
        
        const titleDiv = document.createElement('h3');
        titleDiv.textContent = question.question;
        titleDiv.style.marginBottom = '10px';
        titleDiv.style.textAlign = 'center';
        chartContainer.appendChild(titleDiv);

        const chartDiv = document.createElement('div');
        chartDiv.id = `chart_${index}`;
        chartDiv.style.width = '100%';
        chartDiv.style.height = '300px';
        chartContainer.appendChild(chartDiv);
        
        container.appendChild(chartContainer);

        const dataTable = new google.visualization.DataTable();
        dataTable.addColumn('string', 'Label');
        dataTable.addColumn('number', 'Value');
        
        const rows = question.data.map(item => [item.label, item.value]);
        console.log('Chart rows:', rows);
        dataTable.addRows(rows);

        const options = {
            width: '100%',
            height: '300',
            chartArea: {
                width: '80%',
                height: '70%'
            },
            legend: { position: 'bottom' },
            fontSize: 12
        };

        let chart;
        switch (question.chartType) {
            case 'PieChart':
                chart = new google.visualization.PieChart(document.getElementById(`chart_${index}`));
                break;
            case 'ColumnChart':
                options.legend = { position: 'none' };
                options.vAxis = { 
                    minValue: 0,
                    gridlines: { count: 5 }
                };
                options.bar = { groupWidth: '60%' };
                chart = new google.visualization.ColumnChart(document.getElementById(`chart_${index}`));
                break;
            default:
                chart = new google.visualization.PieChart(document.getElementById(`chart_${index}`));
        }

        try {
            chart.draw(dataTable, options);
            console.log(`Successfully drew chart ${index}`);
        } catch (error) {
            console.error(`Error drawing chart ${index}:`, error);
        }
    });
    
    const line = document.createElement('hr');
    container.appendChild(line);
    const appkingsWebsite = document.createElement('a');
    appkingsWebsite.href = 'https://appkings.co.ke/';
    appkingsWebsite.textContent = 'AppKings Solutions Limited';
    const footer = document.createElement('p');
    footer.style.textAlign = 'center';
    footer.textContent = 'Survey analysis, Powered by ';
    appkingsWebsite.target = '_blank';
    footer.appendChild(appkingsWebsite);
    container.appendChild(footer);
}