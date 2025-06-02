// utills.js

function getFormattedDate(date) {     // gettting the date
    var year = date.getFullYear();
    var month = (date.getMonth() + 1 ).toString().padStart(2,'0');
    var day = date.getDate().toString().padStart(2, '0');
    return `<u>${day}/${month}/${year}</u>`;
}

function getFormattedTime(date) {     // gettting the date
    var hour = ( date.getHours() % 12).toString().padStart(2, '0');
    var min = date.getMinutes().toString().padStart(2, '0');
    return `<u>${hour}:${min}</u>`;
}
