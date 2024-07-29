page 54230 "Approved Repair List  Vehicles"
{
    CardPageID = "Approved Repair Card Vehicles";
    Editable = false;
    PageType = List;
    SourceTable = "Asset Repair Header";
    SourceTableView = WHERE("Asset Type" = CONST(Vehicles),
                            Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Motor Vehicles FA")
            {
                Caption = 'Update Motor Vehicles FA';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Vehicles
                    FixedAsset.RESET;
                    FixedAsset.SETFILTER(FixedAsset."FA Subclass Code", '%1', '');
                    //IF FixedAsset.FIND('-') THEN FixedAsset.MODIFYALL(FixedAsset."Asset Type",FixedAsset."Asset Type"::Vehicles);

                    //Machines

                    //Office Equipement
                    FixedAsset.RESET;
                    FixedAsset.SETFILTER(FixedAsset."FA Subclass Code", '%1|%2|%3', 'FURN_FITT', 'COMP_EQUIP', 'OFF_EQUIP');
                    //IF FixedAsset.FIND('-') THEN FixedAsset.MODIFYALL(FixedAsset."Asset Type",FixedAsset."Asset Type"::"Other Assets");

                    MESSAGE('Done');
                end;
            }
        }
    }

    var
        FixedAsset: Record 5600;
}

