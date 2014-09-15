
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
    var allTimesJSON = $("#times-json").html(),
        allTimes     = $.parseJSON(allTimesJSON);
    
    var times = [];
    allTimes.forEach(function(entry) {
      if (entry.available_date.substring(0, DATE_LENGTH) === date) {
        times.push(entry);
      }
    });
    return times;
  }

  function displayTimes(timings) {
      timeList.innerHTML = "";
      if (timings) {
        timings.forEach(function(entry) {
          var a = document.createElement('a');
          a.href= "javascript:;";
          
          var li = document.createElement('li');
          li.id = entry.id;
          var timeString = convertTimeString(entry.available_from) + " - " +  
                            convertTimeString(entry.available_till);
          li.innerHTML += timeString; 
          
          a.appendChild(li);
          timeList.appendChild(a);
        });  
      }
  }

  function convertTimeString(original) {
    var time = original.substring(DATE_LENGTH + 1);
    var hour = parseInt(time.substring(0,2));
    var ampm = "am";
    if (hour > 12) {
      ampm = "pm"
      hour -= 12;
    }
    var converted = "" + hour + time.substring(2, 5) + ampm;
    return converted;
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
