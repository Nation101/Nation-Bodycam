const Bodycam = new Vue({   
    el: "#Bodycam_Body",

    data: {
        showBody: false,

        gameTime: 0,
        clockTime: {},
        videoNumber: 0,
        player: {},
        callsign: {},
        location: {},
        jobname: {},
    },
    methods: {
        EnableBodycam() {
            this.showBody = true;
        },
        DisableBodycam() {
            this.showBody = false;
        },

        UpdateBodycam(data) {
            this.gameTime = data.gameTime;
            this.clockTime = data.clockTime;
            this.videoNumber = data.videoNumber;
            this.player = data.player;
            this.callsign = data.callsign;
            this.location = data.location;
            this.jobname = data.jobname;
        },

    }
});

document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener('message', function(event) {
            if (event.data.type == "enablebody") {
                
                Bodycam.EnableBodycam();

            } else if (event.data.type == "disablebody") {

                Bodycam.DisableBodycam();

            } else if (event.data.type == "updatebody") {

                Bodycam.UpdateBodycam(event.data.info);

            } else if (event.data.type == "enablegopro") {
                
                GoPro.EnableGoPro();

            } else if (event.data.type == "disablegopro") {

                GoPro.DisableGoPro();

            } else if (event.data.type == "updategopro") {

                GoPro.UpdateGoPro(event.data.info);

            }

        });
    };
};

// GoPro starts here

const GoPro = new Vue({   
    el: "#GoPro_Body",

    data: {
        showGoPro: false,
        gameTime: 0,
        date: {},
        clockTime: {},
        player: {},
    },
    methods: {
        EnableGoPro() {
            this.showGoPro = true;
        },
        DisableGoPro() {
            this.showGoPro = false;
        },

        UpdateGoPro(data) {
            this.date = data.date;
            this.gameTime = data.gameTime;
            this.clockTime = data.clockTime;
            this.player = data.player;
        },

    }
});