var src = {
    steps: 30,
    expo: 6,
    pause: 2
}


var dest = {
    steps: 0,
    expo: 0,
    pause: 0
}

var state = {
    steps: false,
    expo: false,
    pause: true,
    camera: false
}



    function show(id) {
        var el = document.id(id);
        el.show();
    }

    function hide(id) {
        var el = document.id(id);
        el.hide();
    }

    function flash(id) {
        show(id);
        setTimeout(function () {
            hide(id);
        }, 10);
    }


var seconds = 0;

var counter = 0;
var interval = 15;
setInterval(function () {
    counter = counter + interval;
    if (counter >= 1000) {

        if (state.expo) {
            show('expo');
            if (dest.expo == src.expo) {
                dest.expo = 0;
                state.expo = false;
                state.steps = true;
                hide('expo');
            } else {
                dest.expo = dest.expo + 1;
            }
        }

        if (state.pause) {
            if (dest.pause == src.pause) {
                state.pause = false;
                state.camera = true;
                dest.pause = 0;
                hide('pause');
            } else {
                show('pause');
                dest.pause = dest.pause + 1;
            }
        }

        if (state.camera) {
            flash('camera');
            state.camera = false;
            state.expo = true;
        }


        counter = 0;
    }

    if (state.steps) {
        if (dest.steps == src.steps) {
            dest.steps = 0;
            state.steps = false;
            state.pause = true;
        } else {
            dest.steps = dest.steps + 1;
            console.log('steps');
            flash('steps');
        }
    }


}, interval);
