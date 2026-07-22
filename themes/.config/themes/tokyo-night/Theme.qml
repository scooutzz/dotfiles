pragma Singleton
import QtQuick

QtObject {
    property color bg: "#1a1b26"
    property color fg: "#c0caf5"

    property color surface: "#1f2335"
    property color surface_alpha: Qt.rgba(31, 35, 53, 0.5)
    property color surface_dim: "#16161e"
    property color on_surface: "#c0caf5"
    property color on_surface_variant: "#565f89"
    property color surface_container_low: "#1a1b26"
    property color surface_container: "#25273b"
    property color surface_container_high: "#2a2f44"
    property color surface_container_highest: "#3b4261"
    property color surface_bright: "#414868"

    property color primary: "#7aa2f7"
    property color primary_fixed: "#7aa2f7"
    property color on_primary: "#16161e"
    property color inverse_primary: "#bb9af7"
    property color secondary: "#7dcfff"
    property color tertiary: "#bb9af7"
    property color error: "#f7768e"
    property color warning: "#e0af68"
    property color success: "#9ece6a"

    property color selected: "#33467c"
    property color hover: "#7dcfff"
}
