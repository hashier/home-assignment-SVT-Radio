# Radio by Christopher Loessl

This app simply downloads via URLSession a JSON file from SVT. It then processes it with the new swift decodable feature into a set of structs so it can be used inside the app.

The download is done in the background to not block the UI. Same goes for all the image downloads. All images are downloaded on a background thread and set on the main thread to the image view. The images are cached in memory and later saved to disk for later retrieval. I used SDWebImage for this task since it has all the needed parts I needed.

The cell uses `prepareForReuse` to cancel still running download tasks (so it won't happen that a slow download would replace the wanted image) and it also resets the cell to a clean state.

The cell further uses a `didSet` method for setting up the cell so the ViewController just needs a single line to configure the cell and the VC stays therefore nice and clean.

Otherwise the app uses a Result/Either type I introduced (swift might get one soon in the future) to have a nice clean API with the networking layer and the decoding layer of the JSON. No need for crazy double returning optional blocks.

Since I didn't know how much time I should invest I just spend some time on two evenings to implement the things mentioned above therefore most notable Tests are missing (which I would most likely write in Quick and Nimble)

The project needs Carthage to build, if you don't have it installed I can push a commit that has the dependency included in git.

The project has one warning, a missing AppStore Icon, since I don't assume you want to release it to the app store I left that one out (: It has a nice app icon though.

Feel free to give me feedback/code review on my decisions.
