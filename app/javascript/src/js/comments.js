$(document).ready(() => {
    function sessionLikesScore()
    {
    setInterval(function(){   
        $.ajax({
            url: '/index.php?route=ajax/sessionLikesCount', 
            method: 'post',
            dataType: 'text',
        })
        .done (function(obj){  // действия в случае успеха
            console.log('Ответ получен');
            $('#sessionLikesCount').text("Понравилось: " + obj); 
        })
        .fail(function(){   // действия в случае ошибкии
            console.log('Ошибка соединения с сервером');
        });
    }, 5000);  // внутренняя функция будет выполняться каждые 5 секунд
    }
});