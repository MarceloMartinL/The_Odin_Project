// Cuando carga la pagina inmediatamente se crea una planilla de 16 cuadros por lados
// Cuando el cursor pasa por encima de un cuadro el color de fondo cambia a negro

$(document).ready(function() {
  Grid(16);

  $('.box').hover(function() {
    $(this).css("background-color", "black");

  });
   
});

// Al presionar el boton aparece un prompt para escoger el numero de cuadros de la planilla
// Se activa la funcion que remueve la planilla actual
// Se activa la funcion para crea la nueva planilla con el valor ingresado por el usuario

function boxValue() {
	var boxNumb = prompt("Indica la cantidad de cuadros por lado");
    Clean();
	Grid(boxNumb);

    $('.box').hover(function() {
      $(this).css("background-color", "black");
    });
};

// Funcion que remueve la planilla actual

function Clean() {
	$('.box').remove();
}

function blank() {
	$('.box').css("background-color", "white");
}


  
 /* Funcion que crea la planilla de acuerdo al numero de cuadros solicitado y 
    ajustando el tamaño de los cuadros */
 

// function that builds a grid in the "container"

  function Grid(x) {
   for (var rows = 0; rows < x; rows++ ) {
     for (var columns = 0; columns < x; columns++) {
       $('.container').append('<div class="box"></div>');
        };

     };
     $('.box').css({'width': (600/x), 'height': (600/x)});

   };

 



