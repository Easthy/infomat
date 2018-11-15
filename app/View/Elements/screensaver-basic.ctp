        <link type="text/css" href="https://cdn.rawgit.com/nhnent/tui.color-picker/v2.0.0/dist/tui-color-picker.css" rel="stylesheet">
        <link type="text/css" href="/css/service-basic.css" rel="stylesheet">

        <div class="body-container">
            <div class="tui-image-editor-controls">
                <div class="header">
                    <span class="name">Редактор заставки</span>
                    <ul class="menu">
                        <li class="menu-item border input-wrapper">
                            Выбрать файл
                            <input type="file" accept="image/*" id="input-image-file">
                        </li>
                        <li class="menu-item border" id="btn-download">Сохранить на ПК</li>
                    </ul>
                </div>
                <ul class="menu">
                    <li class="menu-item disabled" id="btn-undo">Отменить</li>
                    <li class="menu-item disabled" id="btn-redo">Вернуть</li>
                    <li class="menu-item" id="btn-remove-active-object">Удалить выделенное</li>
                    <li class="menu-item" id="btn-crop">Обрезать</li>
                    <li class="menu-item" id="btn-flip">Отразить</li>
                    <li class="menu-item" id="btn-rotation">Повернуть</li>
                    <li class="menu-item" id="btn-draw-line">Линия</li>
                    <li class="menu-item" id="btn-draw-shape">Фигура</li>
                    <li class="menu-item" id="btn-add-icon">Иконка</li>
                    <li class="menu-item" id="btn-text">Текст</li>
                    <li class="menu-item" id="btn-image-filter">Фильтры</li>
                </ul>
                <div class="sub-menu-container" id="crop-sub-menu">
                    <ul class="menu">
                        <li class="menu-item" id="btn-apply-crop">Применить</li>
                        <li class="menu-item" id="btn-cancel-crop">Отменить</li>
                    </ul>
                </div>
                <div class="sub-menu-container" id="flip-sub-menu">
                    <ul class="menu">
                        <li class="menu-item" id="btn-flip-x"> По оси X</li>
                        <li class="menu-item" id="btn-flip-y"> По оси Y</li>
                        <li class="menu-item" id="btn-reset-flip">Сбросить</li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
                <div class="sub-menu-container" id="rotation-sub-menu">
                    <ul class="menu">
                        <li class="menu-item" id="btn-rotate-clockwise"> По часовой (30)</li>
                        <li class="menu-item" id="btn-rotate-counter-clockwise"> Против часовой(-30)</li>
                        <li class="menu-item no-pointer"><label>Вручную<input id="input-rotation-range" type="range" min="-360" value="0" max="360"></label></li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
                <div class="sub-menu-container menu" id="draw-line-sub-menu">
                    <ul class="menu">
                        <li class="menu-item">
                            <label><input type="radio" name="select-line-type" value="freeDrawing" checked="checked">Свободное рисование</label>
                            <label><input type="radio" name="select-line-type" value="lineDrawing">Прямая линия</label>
                        </li>
                        <li class="menu-item">
                            <div id="tui-brush-color-picker">Цвет кисти</div>
                        </li>
                        <li class="menu-item"><label class="menu-item no-pointer">Ширина кисти<input id="input-brush-width-range" type="range" min="5" max="30" value="12"></label></li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
                <div class="sub-menu-container" id="draw-shape-sub-menu">
                    <ul class="menu">
                        <li class="menu-item">
                            <label><input type="radio" name="select-shape-type" value="rect" checked="checked"> прямоугольник</label>
                            <label><input type="radio" name="select-shape-type" value="circle"> круг</label>
                            <label><input type="radio" name="select-shape-type" value="triangle"> треугольник</label>
                        </li>
                        <li class="menu-item">
                            <select name="select-color-type">
                                <option value="fill">Заливка</option>
                                <option value="stroke">Контур</option>
                            </select>
                            <label><input type="checkbox" id="input-check-transparent">прозрачность</label>
                            <div id="tui-shape-color-picker"></div>
                        </li>
                        <li class="menu-item"><label class="menu-item no-pointer">Толщина контура<input id="input-stroke-width-range" type="range" min="0" max="300" value="12"></label></li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
                <div class="sub-menu-container" id="icon-sub-menu">
                    <ul class="menu">
                        <li class="menu-item">
                            <div id="tui-icon-color-picker">Цвет иконки</div>
                        </li>
                        <li class="menu-item border" id="btn-register-icon">Зарегистрировать выделенное как иконку</li>
                        <li class="menu-item icon-text" data-icon-type="arrow">➡</li>
                        <li class="menu-item icon-text" data-icon-type="cancel">✖</li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
                <div class="sub-menu-container" id="text-sub-menu">
                    <ul class="menu">
                        <li class="menu-item">
                            <div>
                                <button class="btn-text-style" data-style-type="b">Жирный</button>
                                <button class="btn-text-style" data-style-type="i">Курсив</button>
                                <button class="btn-text-style" data-style-type="u">Подчёркнутый</button>
                            </div>
                            <div>
                                <button class="btn-text-style" data-style-type="l">По левому краю</button>
                                <button class="btn-text-style" data-style-type="c">По центру</button>
                                <button class="btn-text-style" data-style-type="r">По правому краю</button>
                            </div>
                        </li>
                        <li class="menu-item"><label class="no-pointer">Размер <input id="input-font-size-range" type="range" min="10" max="100" value="10"></label></li>
                        <li class="menu-item">
                            <div id="tui-text-color-picker">Цвет текста</div>
                        </li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
                <div class="sub-menu-container" id="image-filter-sub-menu">
                    <ul class="menu">
                        <li class="menu-item align-left-top">
                            <table>
                                <tbody>
                                    <tr>
                                        <td><label><input type="checkbox" id="input-check-grayscale">Обесцветить</label></td>
                                        <td><label><input type="checkbox" id="input-check-invert">Инвертировать</label></td>
                                        <td><label><input type="checkbox" id="input-check-sepia">Сепия</label></td>
                                    </tr>
                                    <tr>
                                        <td><label><input type="checkbox" id="input-check-sepia2">Сепия2</label></td>
                                        <td><label><input type="checkbox" id="input-check-blur">Размыть</label></td>
                                        <td><label><input type="checkbox" id="input-check-sharpen">Четкость</label></td>
                                    </tr>
                                    <tr>
                                        <td><label><input type="checkbox" id="input-check-emboss">Тиснение</label></td>
                                    </tr>
                                </tbody>
                            </table>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-remove-white">Удалить белое</label><br>
                                <label>Чувствительность<input class="range-narrow" id="input-range-remove-white-threshold" type="range" min="0" value="60" max="255"></label><br>
                                <label>Дистанция<input class="range-narrow" id="input-range-remove-white-distance" type="range" min="0" value="10" max="255"></label>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-brightness">Яркость</label><br>
                                <label>Значение<input class="range-narrow" id="input-range-brightness-value" type="range" min="-255" value="100" max="255"></label>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-noise">Шум</label><br>
                                <label>Значение<input class="range-narrow" id="input-range-noise-value" type="range" min="0" value="100" max="1000"></label>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-gradient-transparancy">Прозрачность по градиенту</label><br>
                                <label>Значение<input class="range-narrow" id="input-range-gradient-transparency-value" type="range" min="0" value="100" max="255"></label>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-pixelate">Пиксели</label><br>
                                <label>Значение<input class="range-narrow" id="input-range-pixelate-value" type="range" min="2" value="4" max="20"></label>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-tint">Тонировка</label><br>
                                <div id="tui-tint-color-picker"></div>
                                <label>Прозрачность<input class="range-narrow" id="input-range-tint-opacity-value" type="range" min="0" value="1" max="1" step="0.1"></label>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-multiply">Умножить</label>
                                <div id="tui-multiply-color-picker"></div>
                            </p>
                        </li>
                        <li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-blend">Смешать</label>
                                <div id="tui-blend-color-picker"></div>
                                <select name="select-blend-type">
                                    <option value="add" selected>Добавить</option>
                                    <option value="diff">Разница</option>
                                    <option value="diff">Вычесть</option>
                                    <option value="multiply">Умножить</option>
                                    <option value="screen">Экран</option>
                                    <option value="lighten">Осветлить</option>
                                    <option value="darken">Затемнить</option>
                                </select>
                            </p>
                        </li><li class="menu-item align-left-top">
                            <p>
                                <label><input type="checkbox" id="input-check-color-filter">Цветовой фильтр</label><br>
                                <label>Чувствительность<input class="range-narrow" id="input-range-color-filter-value" type="range" min="0" value="45" max="255"></label>
                            </p>
                        </li>
                        <li class="menu-item close">Закрыть</li>
                    </ul>
                </div>
            </div>
            <div class="tui-image-editor"></div>
        </div>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/1.6.7/fabric.js"></script>
        <script type="text/javascript" src="/node_modules/tui-code-snippet/dist/tui-code-snippet.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.3/FileSaver.min.js"></script>
        <script type="text/javascript" src="https://cdn.rawgit.com/nhnent/tui.component.colorpicker/1.0.2/dist/colorpicker.min.js"></script>
        <script type="text/javascript" src="/node_modules/tui-image-editor/dist/tui-image-editor.js"></script>
        <script src="/js/service-basic.js"></script>
