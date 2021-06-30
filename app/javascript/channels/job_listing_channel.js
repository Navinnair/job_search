import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('channel-id');
  const channel_id = element.getAttribute('channel-data');

    consumer.subscriptions.create({channel: "JobListingChannel", channel_id: channel_id}, {
      connected() {
      // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel  

        // remove loading text
        while(element.firstChild && element.removeChild(element.firstChild));

        // result data to array to build table
        var main_array = new Array();
        for (var key in data.item) {
          var array_values = new Array();
          array_values.push(data.item[key].content_id);
          array_values.push(data.item[key].title);
          array_values.push(data.item[key].pubDate);
          main_array.push(array_values)
        }
        
        // is array is empty render no results found
        if (Array.isArray(main_array) && !main_array.length){
          var main_array = [['No Results Found']];
        }

        createTable(main_array);
        
        // create table structure
        function createTable(tableData) {
          var table = document.createElement('table');
          var tableBody = document.createElement('tbody');
        
          tableData.forEach(function(rowData) {
            var row = document.createElement('tr');
        
            rowData.forEach(function(cellData) {
              var cell = document.createElement('td');
              cell.appendChild(document.createTextNode(cellData));
              row.appendChild(cell);
            });
        
            tableBody.appendChild(row);
          });
        
          table.appendChild(tableBody);
          element.appendChild(table);
        }
      }
    });
})
