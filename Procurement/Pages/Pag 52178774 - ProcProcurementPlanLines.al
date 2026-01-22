page 52178774 "Proc-Procurement Plan Lines"
{
    PageType = ListPart;
    SourceTable = "PROC-Procurement Plan Lines";
    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Type No"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field("Votebook Account"; Rec."Votebook Account")
                {
                    Caption = 'Votebook';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Votebook Account field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }

                field("1st Quater"; Rec."1st Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 1st Quater field.';
                }
                field("2nd Quater"; Rec."2nd Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 2nd Quater field.';
                }
                field("3rd Quater"; Rec."3rd Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 3rd Quater field.';
                }
                field("4th Quater"; Rec."4th Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 4th Quater field.';
                }

                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reservation; Rec.Reservation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reservation field.';
                }
                field("Special Group"; Rec."Special Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Group field.';
                }

                field("Procurement Method"; Rec."Procurement Method")
                {
                    ToolTip = 'Specifies the value of the Procurement Method field.';
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved field.';
                }
                field("Quantity Requisitioned"; Rec."Quantity Requisitioned")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Requisitioned field.';
                }


            }
        }
    }

    actions
    {
    }
}

