import QtQuick

Item {
    id: root

    property alias fist: first
    property alias second: second
    property alias third: third
    property alias fouth: fouth
    property alias fifth: fifth

    Mower {
        id: first
        y: 87 * 1.6
    }
    Mower {
        id: second
        y: 87 * 1.6 + 144
    }
    Mower {
        id: third
        y: 87 * 1.6 + 144 * 2
    }
    Mower {
        id: fouth
        y: 87 * 1.6 + 144 * 3
    }
    Mower {
        id: fifth
        y: 87 * 1.6 + 144 * 4
    }
}
