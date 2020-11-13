function LevelLetter(level) {
    result = substr('ABCDEFGH', level - 1, 1);
}

function IsWeapon(item) {
    if (ItemType(item) >= t_Weapon1 && ItemType(item) <= t_Weapon18) {
        result = 1;
    } else {
        result = 0;
    }
}

function GetItemPrice(item) {
    result = ItemCost(item) * 3;
}

function FormatItemName(item) {
    if (IsWeapon(item) == 1) {
        result = ItemFullName(item) + ' ' + LevelLetter(ItemLevel(item));
    } else {
        result = ItemFullName(item);
    }
}

function FormatItemNameWithPrice(item) {
    result = FormatItemName(item) + ' за ' + GetItemPrice(item) + 'cr.';
}

function GetEqTypeGenitiveCase(item) {
    if (ItemType(item) == t_FuelTanks) {
        result = 'топливного бака';
    } else if (ItemType(item) == t_Engine) {
        result = 'двигателя';
    } else if (ItemType(item) == t_Radar) {
        result = 'радара';
    } else if (ItemType(item) == t_Scaner) {
        result = 'сканера';
    } else if (ItemType(item) == t_RepairRobot) {
        result = 'дроида';
    } else if (ItemType(item) == t_CargoHook) {
        result = 'захвата';
    } else if (ItemType(item) == t_DefGenerator) {
        result = 'генератора защитного поля';
    } else {
        result = 'оружия';
    }
}

function CanItemBeBought(item) {
    if (IsWeapon(item) == 1
        || ItemType(item) == t_FuelTanks
        || ItemType(item) == t_Engine
        || ItemType(item) == t_Radar
        || ItemType(item) == t_Scaner
        || ItemType(item) == t_RepairRobot
        || ItemType(item) == t_CargoHook
        || ItemType(item) == t_DefGenerator
    ) {
        result = 1;
    } else {
        result = 0;
    }
}

function ListShipItems(ship, isSellerShip, dialogue) {
    for (int i = 0; i < ShipItems(ship); i = i + 1) {
        if (CanItemBeBought(ShipItems(ship, i)) == 1) {
            InjectAnswer(dialogue, DeleteTags('<FormatItemName(ShipItems(ship, i))>'), ShipItems(ship, i));
        }
    }
}

function ListGiftItems(dialogue, category) {
    int i = 0;
    if (category == 2) {
        for (i = 0; i < ShipArts(Player()); i = i + 1) {
            InjectAnswer(dialogue, DeleteTags('<FormatItemName(ShipArts(Player(), i))>'), ShipArts(Player(), i));
        }
    } else {
        for (i = 0; i < ShipItems(Player()); i = i + 1) {
            if (CanItemBeBought(ShipItems(Player(), i)) == 1) {
                if (category == 1 && IsWeapon(ShipItems(Player(), i)) == 1) {
                    InjectAnswer(dialogue, DeleteTags('<FormatItemName(ShipItems(Player(), i))>'), ShipItems(Player(), i));
                } else if (category == 0 && IsWeapon(ShipItems(Player(), i)) == 0) {
                    InjectAnswer(dialogue, DeleteTags('<FormatItemName(ShipItems(Player(), i))>'), ShipItems(Player(), i));
                }
            }
        }
    }
}

function RoundToThousands(number) {
    result = round(number / 1000 + 1) * 1000;
}

function GetBarterPrice(itemToBuy, itemToSell) {
    if (itemToBuy == 0) {
        result = 0;
    } else {
        result = RoundToThousands(max(ItemCost(itemToBuy) - ItemCost(itemToSell), 0) * 3 + ItemCost(itemToBuy) / 2);
    }
}

function GetBarterString(itemToBuy, itemToSell) {
    result = 'Обменять на ' + DeleteTags(FormatItemName(itemToSell)) + ' и доплатить ' + GetBarterPrice(itemToBuy, itemToSell) + ' cr.';
}

function IsEqCompatible(item1, item2) {
    if (IsWeapon(item1) == 1 && IsWeapon(item2) == 1) {
        result = 1;
    } else if (ItemType(item1) == ItemType(item2)) {
        result = 1;
    } else {
        result = 0;
    }
}

function GetItemTooBigMesssage(ship, itemToBuy, itemToSell) {
    int itemToBuySize = 0;
    if (itemToBuy != 0) {
        itemToBuySize = ItemSize(itemToBuy);
    }
    if (ShipFreeSpace(ship) < ItemSize(itemToSell) - itemToBuySize) {
        result = '- такая махина как ' + FormatItemName(itemToSell) + ' просто не поместится на мой корабль\n';
    } else {
        result = '';
    }
}

function GetItemTooBrokenMesssage(ship, item) {
    if (ItemDurability(item) < 75) {
        result = '- похоже, что ' + FormatItemName(item) + ' не в лучшем состоянии, мои приборы говорят, что осталось ' + ItemDurability(item) + '% до ремонта\n' ;
    } else {
        result = '';
    }
}

function GetRejectSaleReason(ship, itemToBuy, itemToSell) {
    result = GetItemTooBigMesssage(ship, itemToBuy, itemToSell) + GetItemTooBrokenMesssage(ship, itemToSell);
}

function ListBarterOptions(itemToBuy, dialogue) {
    for (int i = 0; i < ShipItems(Player()); i = i + 1) {
        if (IsEqCompatible(itemToBuy, ShipItems(Player(), i)) == 0) {
            continue;
        }
        InjectAnswer(dialogue, GetBarterString(itemToBuy, ShipItems(Player(), i)), ShipItems(Player(), i));
    }
}

function Debug(msg) {
    Ether(0, '--debug--', msg);
}

function IsBarterAllowedForShip(ship) {
    str shipType = ShipType(ship);
    if (
        shipType == 'Ranger'
        || shipType == 'Pirate'
        || shipType == 'Transport'
        || shipType == 'Freelancer'
    ) {
        result = 1;
    } else {
        result = 0;
    }
}

function CheckRelationToPlayer() {
    if (RelationToRanger(GetTalkShip(), Player()) > 0) {
        result = 1;
    } else {
        result = 0;
    }
}

function InjectDialog() {
    dword ship = GetTalkShip();
    if (ship != 0) {
        if (IsBarterAllowedForShip(ship) == 1) {
            AddDialogInject('my_dialog', '', "Я хочу предложить бартер", 1);
        }
    }
}

function GetAnyItemFromShip(ship, item, category) {
    if (category == 2) {
        GetArtFromShip(ship, FindItemInShip(ship, item));
    } else {
        GetItemFromShip(ship, FindItemInShip(ship, item));
    }
}

function Barter(ship, itemToBuy, itemToSell, category) {
    if (itemToBuy != 0) {
        ShipMoney(Player(), ShipMoney(Player()) - GetBarterPrice(itemToBuy, itemToSell));
        GetAnyItemFromShip(ship, itemToBuy, category);
        AddItemToShip(Player(), itemToBuy);
    }
    GetAnyItemFromShip(Player(), itemToSell, category);
    AddItemToShip(ship, itemToSell);
}

function CanStartBarter() {
    if (
        CheckRelationToPlayer() == 1
        && Dist(GetTalkShip(), Player()) <= 200
        && HullDamage(GetTalkShip()) <= 10
    ) {
        result = 1;
    } else {
        result = 0;
    }
}
