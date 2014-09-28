
(function(window, document, undefined) {
  var ENTER_KEY_CODE = 13;
  var DATE_LENGTH = 10;
  $( "#datepicker" ).datepicker({
      altField: "#alternate",
      dateFormat: "yy-mm-dd",
      onSelect: onDateSelected,
    });

  var timeList = document.getElementById('time-list');
  var availableTimes = [];

  function onDateSelected() { 
    var date = $("#alternate").val();
    availableTimes = findTimes(date);
    displayTimes(availableTimes);
    addListeners(availableTimes);
  }
  // add event listener to calendar

  /* Adds a new task item to the list, with the value from the
   * given input.
   *
   * Arguments:
   * taskInput -- the HTMLElement input tag
   */
  function findTimes(date) {
    var orderJSON = $("#order-json").html(),
        order = $.parseJSON(orderJSON);
    var duration = order.cleanduration;
    
    var allTimesJSON = $("#times-json").html(),
        allTimes     = $.parseJSON(allTimesJSON);
    
    var times = [];
    allTimes.forEach(function(entry) {
      if (!entry.available_date)
        return;
      if (findTimeDuration(entry) >= duration) {
         if (entry.available_date.substring(0, DATE_LENGTH) === date) {
            var beginHour = getHour(entry.available_from);
            var endHour = getHour(entry.available_till);
            for (var x = beginHour; x + duration <= endHour; x+=1) {
              times.push({ available_from: x, available_till: x + duration});  
            }
          }
      }
    });


    return times;
  }

  function findTimeDuration(time) {

    var fromHour = getHour(time.available_from);
    var tillHour = getHour(time.available_till);
    return tillHour - fromHour;
  }

  function displayTimes(timings) {
    timeList.innerHTML = "";
    if (timings.length === 0) {
      timeList.innerHTML = "There are no available times on this date for your order duration.";  
    }
    else {
      timings.forEach(function(entry) {
        var a = document.createElement('a');
        a.href= "javascript:;";
        
        var li = document.createElement('li');
        li.id = entry.id;
        var timeString = getAMPM(entry.available_from) + " - " +  
                          getAMPM(entry.available_till);
        li.innerHTML += timeString; 
        
        a.appendChild(li);
        timeList.appendChild(a);
      });  
    }
  }
  function getHour(timestamp) {
    var time = timestamp.substring(DATE_LENGTH + 1);
    var hour = parseInt(time.substring(0,2));
    return hour;
  }
  function getAMPM(hour) {
    var ampm = "am";
    var newHour = hour;
    if (hour > 11) {
      ampm = "pm";
    }
    if (hour > 12) {
      newHour -= 12;
    }
    return "" + newHour + ampm;
  }


  /* Handles check/delete events for the given task.
   *
   * Arguments:
   * taskLi -- the HTMLElement li tag
   */
  function addListeners(times) {
    $('#time-list li').each(function() {

      $(this).click(function() {
        $('#time-list li').each(function() {
          $(this).removeClass("selected");
        });
        $(this).addClass("selected");
      })
    })
  }

})(this, this.document);
