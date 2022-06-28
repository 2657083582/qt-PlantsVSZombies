import QtQuick

Item {
    id: root

    Mower {
        y: 87 * 1.6
    }
    Mower {
        y: 87 * 1.6 + 144
    }
    Mower {
        y: 87 * 1.6 + 144 * 2
    }
    Mower {
        y: 87 * 1.6 + 144 * 3
    }
    Mower {
        y: 87 * 1.6 + 144 * 4
    }
}
