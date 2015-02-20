/**
 * jQVersion.com
 * Author: Mihai MATEI <contact@jqversion.com>
 */
var jsEditor, cssEditor, htmlEditor;
function setBoxesSize() {
    var $width = $(document).width() - 440;
    var $height = boxHeight = $(window).height() - 81;
    
    if ($width <= 400)
        $width = 400;
    if ($height <= 400)
        $height = 400;
        
    $('#code-container').width($width);
    $('#html-js-boxes, #css-result-boxes').width($width / 2).css('min-width', $width / 2);
    $('#result-box').width($width / 2 - 2);
    $('#code-container, .right-sidebar, #versions')
        .height($height)
        .css('max-height', $height);
    $('.box, .CodeMirror, .CodeMirror-gutters, #result-iframe')
        .height($height / 2)
        .css('min-height', $height / 2);
}

function createIframe(attrId, parentElement, versionId, jqSource) {
    if ($('#' + attrId).size()) {
        $('#' + attrId).remove();
    }
    
    // create iframe
    var iframe = document.createElement('iframe');
        iframe.setAttribute('id', attrId);
    
    parentElement.prepend($(iframe));
    
    var    doc = iframe.contentWindow.document;
        doc.open();
        doc.write('<html>'
                  + '<head></head>'
                  + '<body>'
                  + htmlEditor.getValue()
                  + '</body>'
                  + '</html>');
        doc.close();
    
    var iFrameHead = document.getElementById(attrId).contentWindow.document.head || document.getElementById(attrId).contentWindow.document.getElementsByTagName('head')[0];
    
    var script = document.createElement('script');
        script.setAttribute('type', 'text/javascript');
        script.text = 'var versionId = ' + versionId + '; \r\n window.onerror = function(msg, url, line) { \r\n window.parent.errorsHandler(msg, url, line, versionId); \r\n return true; \r\n }; \r\n';
    iFrameHead.appendChild(script);
        
        script = document.createElement('script');
        script.setAttribute('type', 'text/javascript');
        script.setAttribute('src', jqSource);
    iFrameHead.appendChild(script);
    
    var style = document.createElement('style'),
        styleCssText = cssEditor.getValue();
        styleCssText += ' \r\n body {margin:2px;}';
        style.type = 'text/css';
    if (style.styleSheet){
          style.styleSheet.cssText = styleCssText;
    } else {
          style.appendChild(document.createTextNode(styleCssText));
    }
    iFrameHead.appendChild(style);
        
    setTimeout(function(){
        var script = document.createElement('script');
            script.setAttribute('type', 'text/javascript');
            script.text = '//<![CDATA[ \r\n $(function(){ \r\n window.parent.iframeIsLoaded(versionId); \r\n ' + jsEditor.getValue() + ' \r\n }); //]]>';
        if (versionId == 0) {
            script.text += '\r\n $(\'body > *\').bind("' + $('#events-to-be-listened').val() + '", parent.bindFunction);';
        }
        iFrameHead.appendChild(script);
        
        $('span.result', parentElement).html('').removeClass('no-background');
        if (!$('span.result', parentElement).hasClass('error')) {
            $('span.result', parentElement).addClass('success');
        }
    }, 1000);
}

function iframeIsLoaded(versionId) {
    if (versionId == 0) {
        $nextVersionToLoad = $("#versions li input[type=checkbox]:checked").first().parent().parent();
    } else {
        $index = $('#versions li').index($("#container-version-" + versionId));
        $nextVersionToLoad = $("#versions li:gt(" + $index + ") input[type=checkbox]:checked").first().parent().parent();
    }
    
    if ($nextVersionToLoad.size()) {
        createIframe('result-iframe-' + $nextVersionToLoad.data('version-id'), $nextVersionToLoad, $nextVersionToLoad.data('version-id'), $nextVersionToLoad.data('version-jquery-source'));
    } else {
        showGlobalNotification('All selected jQuery versions were loaded successful.', 'success');
        $('#main-loader').hide();
    }
}

window.onerror = function(msg, url, line) { 
    errorsHandler(msg, url, line, -1);
    return true;
}

function errorsHandler(msg, url, line, versionId) {
    var element = '.result-box-hint';
    if (versionId > 0) {
        element = '#container-version-' + versionId;
    }
    $(element + ' > span.result').html('').removeClass('success no-background').addClass('error');
    $(element).data('error', msg);
    $('#main-loader').hide();
}

function bindFunction(e) {
    var target = e.target || e.srcElement;
    $('#versions ul li.active').each(function(){
        var iframe = $(this).find("iframe").contents();
        $($(target).getPath(), iframe).trigger(e);
    });
    $('#actions').val(function(_, val){
        return val + $(target).getPath() + ',' + e.type + ';'; 
    });
}
    
function resetSettings(removeMainIframe) {
    $('#actions').val('');
    $('span.result').removeClass('success error');
    $('.result-box-hint').find('span.result').html('').removeClass('no-background success error');
    if (removeMainIframe) {
        $('#result-box').find('iframe').remove();
    }
}

function showGlobalNotification(text, type) {
    var target = $('.qtip.jgrowl:visible:last');
    $('<div/>').qtip({
        content: {
            text: text,
            title: {
                text: type == 'success' ? 'Success' : (type == 'error' ? 'Error' : 'Info'),
                button: false
            }
        },
        position: {
            target: [0,0],
            container: $('#qtip-growl-container')
        },
        show: {
            event: false,
            ready: true,
            effect: function() {
                $(this).stop(0, 1).animate({ height: 'toggle' }, 400, 'swing');
            },
            delay: 0,
            persistent: true
        },
        hide: {
            event: false,
            effect: function(api) {
                $(this).stop(0, 1).animate({ height: 'toggle' }, 400, 'swing');
            }
        },
        style: {
            width: 250,
            classes: 'jgrowl qtip-rounded qtip-shadow qtip-' + (type == 'success' ? 'green' : (type == 'error' ? 'red' : 'info')),
            tip: false
        },
        events: {
            render: function(event, api) {
                api.timer = setTimeout(function() { api.hide() }, 9000);
            }
        }
    });
}

$(window).resize(function(){
    setBoxesSize();
});

var saved      = false;
var changes    = false;
var firstVisit = true;

$(window).on('beforeunload', function(){
    if (!changes) {
        return;
    }
    return "You have unsaved changes! Continue?";
});

$(document).ready(function(){
    jsEditor = CodeMirror.fromTextArea(document.getElementById("js-editor"), {
        lineNumbers: true,
        lineWrapping: true,
        styleActiveLine: true,
        matchBrackets: true,
        mode: "text/javascript",
        theme: "eclipse",
        change: function() {
            console.log('test');
        }
    });
    jsEditor.on("change", function(jsEditor, change) {
        if (change.origin != 'setValue') {
            changes = true;
        }
    });
    htmlEditor = CodeMirror.fromTextArea(document.getElementById("html-editor"), {
        lineNumbers: true,
        lineWrapping: true,
        styleActiveLine: true,
        mode: 'text/html',
        autoCloseTags: true,
        theme: "eclipse"
    });
    htmlEditor.on("change", function(htmlEditor, change) {
        if (change.origin != 'setValue') {
            changes = true;
        }
    });
    cssEditor = CodeMirror.fromTextArea(document.getElementById("css-editor"), {
        lineNumbers: true,
        lineWrapping: true,
        styleActiveLine: true,
        mode: 'text/css',
        autoCloseTags: true,
        theme: "eclipse"
    });
    cssEditor.on("change", function(cssEditor, change) {
        if (change.origin != 'setValue') {
            changes = true;
        }
    });
    
    setBoxesSize();
    
    $('.CodeMirror').find('textarea').focus(function(){
        $('.box-hint', $(this).parent().parent().parent()).fadeOut();
    }).blur(function(){
        $('.box-hint', $(this).parent().parent().parent()).fadeIn();
    });
    
    $('#result-box .box-hint').css('opacity', .8);
    
    $('#versions ul li input[type=checkbox]').change(function(){
        if($(this).is(':checked')) {
            $(this).parent().parent().addClass('active');
        } else {
            $(this).parent().parent().removeClass('active');
        }
    });
    
    $('#versions ul li, .result-box-hint').on('mouseenter', 'span.error, span.success', function (event) {
        var text = null;
        var qtipClass = 'qtip-green';
        if ($(this).hasClass('error')) {
            text = $(this).parent().data('error');
            qtipClass = 'qtip-red';
        } else {
            if ($(this).parent().data('version-name') == undefined) {
                $(this).parent().data('version-name', $('#working-jquery-version > option:selected').text());
            }
            text = $(this).parent().data('version-name') + ' has been successfully loaded and/or \n the actions taken were successful in this version.';
        }
        
        $(this).qtip({
            overwrite: true,
            content: {
                text: text
            },
            position: {
                my: 'top right',
                at: 'bottom left',
            },
            show: {
                event: event.type,
                ready: true
            },
            style: {
                classes: 'qtip-rounded qtip-shadow ' + qtipClass
            }
        });

    });
    
    $('#run').click(function(e){
        e.preventDefault();
        
        resetSettings(false);
        
        $('#main-loader').css('display', 'inline-block');
        $('.result-box-hint').find('span.result').addClass('no-background').html('<img src="/resources/images/ajax-loader.gif" />');
        
        $('#versions ul li input[type=checkbox]:checked').each(function(){
            var li = $(this).parent().parent();
            li.find('span.result').addClass('no-background').html('<img src="/resources/images/ajax-loader.gif" />');
        });
		
		ga('send', 'pageview', '/' + $.address.value());
        
        createIframe('result-iframe', $('#result-box'), 0, $('#working-jquery-version > option:selected').data('version-jquery-source'));
    });
    
    $('#save').click(function(e){
        e.preventDefault();
        
        if (jsEditor.getValue() == "" && htmlEditor.getValue() == "") {
            showGlobalNotification('The test cannot be saved. You have to add content in at least one of the HTML or Javascript windows.', 'error');
            return;
        }
        
        $this = $(this);
        $('#main-loader').css('display', 'inline-block');
        $.ajax({
            url: '/save',
            type: 'POST',
            dataType: 'json',
            data: {
                js:   jsEditor.getValue(),
                html: htmlEditor.getValue(),
                css:  cssEditor.getValue(),
                workingVersion: $('#working-jquery-version').val(),
                eventsToBeListened: $('#events-to-be-listened').val(),
                versionsToBeTested: $('input[name="run-version[]"]:checked').map(function(){return $(this).val();}).get(),
                autorun: $('#autorun:checked').length,
                actions: $('#actions').val(),
                identifier: $.address.hash(),
                fork: $this.data('fork')
            },
            success: function(data){
                if (data.error !== null) {
                    showGlobalNotification(data.error, 'error');
                    $('#main-loader').hide();
                    return;
                }
                
                saved   = true;
                changes = false;
                $.address.value('#!/' + data.identifier);
				ga('send', 'pageview', '/' + $.address.value());
				
                $('#test-link').val($.address.baseURL() + $.address.value());
                $('#main-loader').hide();
                
                if ($this.data('fork') == 1) {
                    showGlobalNotification('The test has been successfully forked.', 'success');
                    $this.data('fork', 0);
                } else {
                    showGlobalNotification('The test has been successfully saved.', 'success');
                }
            }
        });
    });
    
    $('#fork').click(function(e){
        e.preventDefault();
        $('#save').data('fork', 1).trigger('click');
    });
    
    $('#share').click(function(e){
        e.preventDefault();
        if (!$(this).hasClass('active')) {
            var pos = $(this).offset();
            $('#share-menu').css('left', pos.left).slideDown();
            $(this).addClass('active').find('span.ui-icon-triangle-1-s').addClass('ui-icon-triangle-1-n');
        } else {
            $('#share-menu').slideUp();
            $(this).removeClass('active').find('span.ui-icon-triangle-1-s').removeClass('ui-icon-triangle-1-n');
        }
    });
    
    $.address.change(function(e){
        var pattern = /^\/\#\!\/[a-zA-Z0-9]{7}(\/[0-9]*)?$/g;
        if (e.value.match(pattern) !== null && !saved) {
            
            resetSettings(true);
            $('#main-loader').css('display', 'inline-block');
            $('#test-link').val($.address.baseURL() + $.address.value());
            
            $.ajax({
                url: '/get',
                type: 'POST',
                dataType: 'json',
                data: {
                    identifier: e.value
                },
                success: function(data){
                    if (data.error !== null) {
                        showGlobalNotification(data.error, 'error');
                           $('#main-loader').hide();
                        return;
                    }
                    
                    htmlEditor.setValue(data.html);
                    cssEditor.setValue(data.css);
                    jsEditor.setValue(data.js);
                    $('#working-jquery-version').val(parseInt(data.workingVersion));
                    $('#events-to-be-listened').val(data.eventsToBeListened);
                    if (data.versionsIds !== null) {
                        var versions = data.versionsIds.split(',');
                        $('input[name="run-version[]"]').each(function(){
                            if ($.inArray($(this).val(), versions) !== -1) {
                                $(this).prop('checked', true);
                            } else {
                                $(this).prop('checked', false);
                            }
                        });
                    } else {
                        $('input[name="run-version[]"]').prop('checked', false);
                    }
                    $('#actions').val(data.actions);
                    
                    $('#main-loader').hide();
                    
                    if (data.autorun == '1') {
                        $('#autorun').prop('checked', true);
                        $('#run').trigger('click');
                    } else {
                        $('#autorun').prop('checked', false);
                    }
                }
            });
        }
        if (saved) {
            saved = false;
        }
        if (!firstVisit) {
            ga('send', 'pageview', '/' + $.address.value());
        } else {
            firstVisit = false;
        }
    });
    
});