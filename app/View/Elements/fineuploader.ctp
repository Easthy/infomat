<link href="/fineuploader/fine-uploader-gallery.min.css" rel="stylesheet">
<script src="/fineuploader/fine-uploader.min.js"></script>
<script type="text/template" id="qq-template">
    <div class="qq-uploader-selector gallery-item uploader qq-gallery" qq-drop-area-text="+">
        <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
            <span class="qq-upload-drop-area-text-selector"></span>
        </div>
        <div class="qq-upload-button-selector upload-button d-flex justify-content-center align-items-center">
            <img src="/img/icons/upload_file.png">
        </div>

        <div class="qq-upload-list-selector qq-upload-list" role="region" aria-live="polite" aria-relevant="additions removals">
            <div class="col-lg-2 py-2 d-flex justify-content-center gallery-preview-item">
                <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                <div class="qq-thumbnail-wrapper containerimg">
                    <div class="gallery-item">
                      <img class="qq-thumbnail-selector image m-auto" qq-max-size="120" qq-server-scale>
                    </div>
                    <div class="overlay">
                        <div class="actions">
                            <img src="/img/icons/delete_white.png" class="qq-btn qq-upload-delete-selector qq-upload-delete">
                        </div>
                    </div>
                    <?php if($this->request->controller == 'home'): ?>
                    <div class="overlay-visible">
                        <input type="checkbox" class="checkbox-round"/>
                        <label class="checkbox-label"></label>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</script>

<style type="text/css">
.actions {
    position: absolute;
    bottom: 10px;
    right: 10px;
}

.actions img {
    width: 20px !important; 
    height: 20px !important;
    border: none !important;
    margin: 0 3px;
}

.icon-check {
    width: 20px !important; 
    height: 20px !important;
    border: none !important;
    margin: 10px;
}

.gallery-item {
    width: 131px;
    height: 88px;
    border: 1px solid lightgrey;
}

.gallery-item.uploader {
    border: 1px solid lightgrey;
}

.gallery-item img{
    max-width: 131px;
    max-height: 88px;
}

.upload-button {
    width: 100%;
    height: 100%;
}

.upload-button img {
    width: 40px;
    height: 40px;
    border: none;
}

.qq-upload-button-hover {
    background: none !important;
}

.containerimg {
  position: relative;
}

.image {
  display: block;
}

.overlay-visible {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  pointer-events: none;
}

.checkbox-label {
  pointer-events: all;
}

.overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: rgba(0, 0, 0, 0.5);
}

.containerimg:hover .overlay {
  opacity: 1;
}

.text {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
}
</style>