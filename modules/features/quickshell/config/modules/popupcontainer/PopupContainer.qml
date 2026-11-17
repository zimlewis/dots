pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.services as Services
import qs.configs as Configs
import qs

PanelWindow {
    property bool activating: true
    property string activatingModule: ""
    property var activeComponent: null
    property double popupX: 0
    property double popupY: 0
    property double popupWidth: 0
    property double popupHeight: 0
	property real baseWidth: 0
	property real baseHeight: 0
	property bool inited: false

	onActivatingChanged: {
		GlobalStates.popupOpen = activating
	}

	onActivatingModuleChanged: {
		GlobalStates.currentPopup = activatingModule
	}

	onHeightChanged: {
		if (root.visible && root.height != 0) {
			root.baseHeight = height
		}
	}

	onWidthChanged: {
		if (root.visible && root.width != 0) { 
			root.baseWidth = width 
		}
	}

    id: root
    visible: activating
    color: "transparent"
    focusable: inited

	mask: Region {
		x: popupContentWrapper.x
		y: popupContentWrapper.y
		width: popupContentWrapper.width
		height: popupContentWrapper.height
	}

	Connections {
		target: Services.PopupController


		function onTogglePopup(x, y, width, height, component, popupId) { root.toggle(x, y, width, height, component, popupId) }
	}

	Timer {
		interval: 1
		running: true
		onTriggered: {
			root.activating = false
			root.inited = true
		}
	}


    anchors { top: true; left: true; right: true; bottom: true }
    margins { top: 5; left: 10; right: 10; bottom: 3 }
    exclusiveZone: 0

	function toggle(x, y, width, height, component, popupId) {
		if (x < 0) {
			x = (root.baseWidth - width / 2) + x
		}
		if (y < 0) {
			y = (root.baseHeight - height / 2) + y
		}
		if (root.activatingModule !== popupId) {
			root.popupX = x;
			root.popupY = y;
			root.popupWidth = width;
			root.popupHeight = height;
			root.activatingModule = popupId;

			if (!root.activating) {
				// Open from nothing
				popupContentWrapper.width = width;
				popupContentWrapper.height = height;
				popupContentWrapper.scale = 0.95;
				popupContentWrapper.x = root.calculatePositionX(x, width);
				popupContentWrapper.y = root.calculatePositionY(y, height);

				root.activeComponent = component;
				contentLoader.sourceComponent = root.activeComponent;
				contentLoader.item.open()
				teleportPopupAnimation.start()
			}
			else {
				// Open new
				fadeOut.pendingComponent = component;
				fadeOut.start();
				movingPopupAnimation.start();
			}

			openAnimation.start();
		}
		else {
			root.close();
		}

	}

    function fireSignalToPopup() {
        contentLoader.item.open()
    }

    function close() {
        root.activatingModule = "";
        closeAnimation.start();
    }

    function calculatePositionX(pPos, pWidth) {
        const minX = 0;
        const maxX = root.baseWidth - pWidth;

        return Math.min(Math.max(pPos - pWidth / 2, minX), maxX);
    }

	function calculatePositionY(pPos, pHeight) {
		const minY = 0;
		const maxY = root.baseHeight - pHeight;

		return Math.min(Math.max(pPos - pHeight / 2, minY), maxY)
	}



    MouseArea {
        anchors.fill: parent
        visible: root.activating
        onClicked: {
            close();
        }
    }

    

    Rectangle {
        property bool entered: false
        id: popupContentWrapper

        color: Configs.Colors.surface
        radius: Services.Configuration.configs.borderRadius
        antialiasing: true
        clip: true

        border {
            color: Configs.Colors.outlineVariant
        }

        transformOrigin: Item.Top

        MouseArea {
            anchors.fill: parent
        }

        HoverHandler {
            id: popupHoverHandler
            onHoveredChanged: {
                if (popupHoverHandler.hovered == true) {
                    popupContentWrapper.entered = true
                }
            }
        }

        Timer {
            id: popupCloseTimer
            interval: 500
            // running: !popupHoverHandler.hovered && root.activating && popupContentWrapper.entered
            running: false
            onTriggered: {
                root.close();
            }
        }

		ParallelAnimation {
			id: teleportPopupAnimation
            ScriptAction {
				script: { 
					popupContentWrapper.y = root.calculatePositionY(root.popupY, root.popupHeight)
					popupContentWrapper.x = root.calculatePositionX(root.popupX, root.popupWidth)
				}
            }
		}

		ParallelAnimation {
			id: movingPopupAnimation
			NumberAnimation {
				target: popupContentWrapper; property: "y"
				to: root.calculatePositionY(root.popupY, root.popupHeight)
				easing.type: Easing.OutCubic
				duration: 300
			}

			NumberAnimation {
				target: popupContentWrapper; property: "x"
				to: root.calculatePositionX(root.popupX, root.popupWidth)
				easing.type: Easing.OutCubic
				duration: 300
			}
		}

        SequentialAnimation {
            id: openAnimation

            ScriptAction {
				script: { 
					root.activating = true 

					popupContentWrapper.entered = false;
				}
            }


            ParallelAnimation {


                NumberAnimation {
                    target: popupContentWrapper; property: "opacity"
                    to: 1
                    easing.type: Easing.OutBack
                    duration: 300
                }

                NumberAnimation {
                    target: popupContentWrapper; property: "scale"
                    to: 1
                    easing.type: Easing.OutBack
                    duration: 300
                }

                NumberAnimation {
                    target: popupContentWrapper; property: "width"
                    to: root.popupWidth
                    easing.type: Easing.OutCubic
                    duration: 300
                }

                NumberAnimation {
                    target: popupContentWrapper; property: "height"
                    to: root.popupHeight
                    easing.type: Easing.OutCubic
                    duration: 300
                }
            }
        }

        SequentialAnimation {
            id: closeAnimation


            ParallelAnimation {

                NumberAnimation {
                    target: popupContentWrapper; property: "opacity"
                    to: 0
                    easing.type: Easing.InBack
                    duration: 300
                }

                NumberAnimation {
                    target: popupContentWrapper; property: "scale"
                    to: 0.95
                    easing.type: Easing.InBack
                    duration: 300
                }
            }
            ScriptAction {
                script: { 
                    contentLoader.item.close()
                    root.activating = false 
                    root.activeComponent = null
                }
            }
        }


        Loader {
            id: contentLoader
            anchors.fill: parent

            // Crossfade animation when switching components
            SequentialAnimation {
                id: fadeOut
                property var pendingComponent

                NumberAnimation {
                    target: contentLoader
                    property: "opacity"
                    to: 0
                    duration: 120
                    easing.type: Easing.InQuad
                }
                ScriptAction {
                    script: { 
                        contentLoader.item.close()
                        contentLoader.sourceComponent = fadeOut.pendingComponent
                        contentLoader.item.open()
                    }
                }
                NumberAnimation {
                    target: contentLoader
                    property: "opacity"
                    to: 1
                    duration: 180
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}


