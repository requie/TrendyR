// x1, y1, x2, y2 - Координаты для обрезки изображения
// crop - Папка для обрезанных изображений
var x, y, w, h;
var real_width,real_height;
var jcrop_api;

jQuery(function($){

  $('#target').Jcrop({
    onChange:   showCoords,
    onSelect:   showCoords,
    trueSize : [ 1024, 768 ]
  },function(){
    var bounds = this.getBounds();
    boundx = bounds[0];
    boundy = bounds[1];

    jcrop_api = this;
  });
  // Снять выделение
  $('#release').click(function(e) {
    release();
  });
  // Соблюдать пропорции
  $('#ar_lock').change(function(e) {
    jcrop_api.setOptions(this.checked?
    { aspectRatio: 4/3 }: { aspectRatio: 0 });
    jcrop_api.focus();
  });
  // Установка минимальной/максимальной ширины и высоты
  $('#size_lock').change(function(e) {
    jcrop_api.setOptions(this.checked? {
      minSize: [ 80, 80 ],
      maxSize: [ 350, 350 ]
    }: {
      minSize: [ 0, 0 ],
      maxSize: [ 0, 0 ]
    });
    jcrop_api.focus();
  });
  // Изменение координат
  function showCoords(c){
    x = c.x; $('#x').val(c.x);
    y = c.y; $('#y').val(c.y);

    w = c.w; $('#w').val(c.w);
    h= c.h; $('#h').val(c.h);

    if(c.w > 0 && c.h > 0){
      $('#cropbutton').show();
    }else{
      $('#cropbutton').hide();
    }
  }
});

function release(){
  jcrop_api.release();
  $('#cropbutton').hide();
}
