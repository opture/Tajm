/*  jquery */

var helpers = {


    hasScrollToTopButton: false,
    decodeText: function (textToDecode) {
        'use strict';
        var div = document.createElement('div');
        div.innerHTML = textToDecode;
        var decoded = div.firstChild.nodeValue;
        div = null;
        return decoded;
    },
    createQueryString: function (obj) {
        'use strict';
        var retval = [];
        for (var p in obj) {
            if (obj.hasOwnProperty(p)) {
                retval.push(encodeURIComponent(p) + '=' + encodeURIComponent(obj[p]));
            }
        }
        return retval.join('&');
    },
    // createInlineSVG: function(){
    //     'use strict';
    //     console.log('creating inline svgs');
    //     $('.svg:not(.replaced-svg)').each(function(){
    //         console.log('got an image');
    //         var $img = Zepto(this);
    //         var imgID = $img.attr('id');
    //         var imgClass = $img.attr('class');
    //         var imgURL = $img.attr('src');

    //         Zepto.get(imgURL, function(data) {
    //             // Get the SVG tag, ignore the rest
    //             var $svg = Zepto(data).find('svg');

    //             // Add replaced image's ID to the new SVG
    //             if(typeof imgID !== 'undefined') {
    //                 $svg = $svg.attr('id', imgID);
    //             }
    //             // Add replaced image's classes to the new SVG
    //             if(typeof imgClass !== 'undefined') {
    //                 $svg = $svg.attr('class', imgClass+' replaced-svg');
    //             }

    //             // Remove any invalid XML tags as per http://validator.w3.org
    //             $svg = $svg.removeAttr('xmlns:a');

    //             // Replace image with new SVG
    //             $img.replaceWith($svg);

    //         }, 'xml');

    //     });
    // },
    /** sets mutiple attrbiutes on a element.
     * @param {DomElement} el - The dom element to add attrbiutes to.
     * @param {Object} attrs - Object with the attrbiutes to set. Key is the attribute, and value will be the value.
     * @returns {void}
     */
    setMultipleAttributes: function (el, attrs) {

        'use strict';
        attrs.forEach(function (attr) {
            var attribute = Object.keys(attr)[0];
            var value = attr[Object.keys(attr)[0]];
            el.setAttribute(attribute, value);
        });
    },

    /** Get an icon from entypo-element
     * @param [string] - iconId, the id for the icon to fetch.
     * @returns [SVGElement] - The icon as a SVG element.
     */
    getIconById: function (iconId) {
        'use strict';
        var iconCollectionElement = document.getElementsByTagName('entypo-icons')[0];
        //Return a cloned node.
        var theIcon = iconCollectionElement.querySelector('#' + iconId);
        var clonedIcon = theIcon.cloneNode(true);
        return clonedIcon;
        //return iconCollectionElement._tag.getIcon(iconId).cloneNode(true);
    },
    addSvgIcon: function (element) {
        'use strict';
        //Get the id of the icon to fetch.
        var iconId = element.getAttribute('entypo-icon');
        //If entypo-icon wasnt set then just return.
        if (!iconId) {
            return;
        }
        //Fetch the icon.
        var svgIcon = helpers.getIconById(iconId);
        //Apend it to the element. (No checking for self-closing elements.)
        element.appendChild(svgIcon);
        //Set class added-svg so we dont try to add the icon again.
        element.classList.add('added-svg');
    },
    addIcons: function (tag) {
        'use strict';
        //Get icons in the tag.
        var icons = tag.root.querySelectorAll('[entypo-icon]:not(.added-svg)');

        //Loop over and inject svg in element.
        for (var i = 0; i < icons.length; i++) {
            helpers.addSvgIcon(icons[i]);
        }
    },
    initPageTag: function (tag) {
        'use strict';
        //If there are attributes to be set to the dom element.
        if (tag.attrs) {
            helpers.setMultipleAttributes(tag.root, tag.attrs);
        }

        helpers.handleScroll(tag.root, tag.scrollRevealClass);
        helpers.addIcons(tag);
    },
    //Check if element is visible in viewport.
    elementInView: function (e, el) {
        'use strict';
        //Remove jquery references.
        if (e[0]) {
            e = e[0];
        }
        if (el[0]) {
            el = el[0];
        }

        var viewPortBottom = e.scrollTop + e.offsetHeight;
        if (el.offsetTop < viewPortBottom) {
            return true;
        }
        return false;
    },

    //This is the apps handler for the scroll event.
    handleScroll: function (e, animClass) {
        'use strict';
        var imgSrc;
        //remove jquery wrap.
        if (e[0]) {
            e = e[0];
        }

        //Reveal hidden items if they are in view.
        var hiddenElements = e.querySelectorAll('.hidden');
        for (var i = 0; i < hiddenElements.length; ++i) {
            var item = hiddenElements[i];
            if (helpers.elementInView(e, item)) {
                item.classList.remove('hidden');
                item.classList.add(animClass);
                var imgs = item.querySelectorAll('[data-src]');
                for (var j = 0; j < imgs.length; j++) {
                    var img = imgs[j];
                    imgSrc = img.getAttribute('data-src');
                    img.setAttribute('src', imgSrc);
                }
                var divs = item.querySelectorAll('[data-style-background]');
                for (var x = 0; x < divs.length; x++) {
                    var thisdiv = divs[x];
                    imgSrc = thisdiv.getAttribute('data-style-background');
                    console.log('Div image: ' + imgSrc);
                    thisdiv.style.backgroundImage = 'url(\'' + imgSrc + '\')';
                }
            }
        }

        //Just check if we should add a scroll to top button.
        if (e.scrollTop > e.offsetHeight && !helpers.hasScrollToTopButton) {
            console.log('Scrolltop button');
            helpers.hasScrollToTopButton = true;

            helpers.scrollToTopButton = document.createElement('b');


            helpers.scrollToTopButton.setAttribute('id', 'scrollToTop');
            helpers.scrollToTopButton.setAttribute('entypo-icon', 'Arrow_up');
            helpers.scrollToTopButton.classList.add('control-icon');
            helpers.scrollToTopButton.classList.add('bounceInUpRight');
            helpers.scrollToTopButton.classList.add('animated-x-slow');
            helpers.scrollToTopButton.classList.add('scroll-to-top');
            helpers.scrollToTopButton.addEventListener('tap', function () {
                var step = e.offsetHeight / 4;
                var anim = setInterval(function () {
                    if (e.scrollTop <= 0 || e.scrollTop < step) {
                        e.scrollTop = 0;
                        clearInterval(anim);
                        anim = null;
                    }
                    e.scrollTop = e.scrollTop - step;
                }, 1);
            });
            document.body.appendChild(helpers.scrollToTopButton);
            helpers.addSvgIcon(helpers.scrollToTopButton);
        }
        if (e.scrollTop < e.offsetHeight && helpers.hasScrollToTopButton) {

            var parent = helpers.scrollToTopButton.parentNode;
            parent.removeChild(helpers.scrollToTopButton);
            helpers.hasScrollToTopButton = false;
        }
        //Check if user scrolled to bottom.
        if (e.scrollHeight - 100 < (e.offsetHeight + e.scrollTop) && e.scrollTop > 0) {
            //>Announce that we hit bottom.
            console.log(e.tagName.toLowerCase() + '-hit-bottom');
            app.dispatcher.trigger(e.tagName.toLowerCase() + '-hit-bottom');
        }
    }

};
