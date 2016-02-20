
function next_li(type, str)
{
  if (!str)
    return type;
  if (type == "1")
  {     
    i = parseInt(str);
    return i + 1;
  }
  if (type == 'a' || type == 'A')
  {
    var x = str.charCodeAt(0);
    return String.fromCharCode(x + 1);
  }
  if (type == 'aa' || type == 'AA')
  {
    var x = str.charCodeAt(0);
    var y = String.fromCharCode(x + 1)
    return "" + y + y;
  }  
  if (type == 'I')
  {
    var numerals = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII', 'XIII', 'XIV', 'XV'];
    var next = false;
    $(numerals).each(function(i, n) {
      if (n == str)
      {
        next = numerals[i+1];
        return false;
      }        
    });
    return next;
  }
  return false;
}

function add_parentheses()
{
  $("ol").each(function(i, ol) {
    var type = $(ol).attr('type');
    var str = false;
    $(ol).find("li").each(function(i, li) {
      str = next_li(type, str); 
      $(li).prepend("(" + str + ") ");    
    });         
  });
}

$(document).ready(function() {
  add_parentheses();     
});
