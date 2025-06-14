// /utills/ui.js

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

function isToday(isoDateStr) {
    if (typeof isoDateStr !== "string") {
        console.error("Invalid input: Expected a string, got", typeof isoDateStr);
        console.log("isoDateStr:", isoDateStr, "Type:", typeof isoDateStr);
        return false;
    }
    let today = new Date()
    let [y, m, d] = isoDateStr.split("-").map(Number)
    return today.getFullYear() === y &&
           (today.getMonth() + 1) === m &&
           today.getDate() === d
}

function formatDate(isoDateStr) {
    if (typeof isoDateStr !== "string") {
        console.error("Invalid input:", isoDateStr);
        console.log("isoDateStr:", isoDateStr, "Type:", typeof isoDateStr);
        return "Invalid Date";
    }
    let [y, m, d] = isoDateStr.split("-")
    return `<u>${d}/${m}/${y}</u>`
}

