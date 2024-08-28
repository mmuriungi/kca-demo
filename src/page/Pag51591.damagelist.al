page 51591 "damage list"
{
    Caption = 'damage list';
    PageType = List;
    CardPageId = "damage card";
    SourceTable = damages;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("damage number"; Rec."damage number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the damage number field.', Comment = '%';
                }
                field("Damage Description"; Rec."Damage Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Damage Description field.', Comment = '%';
                }
                field("student  Number"; Rec."student  Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student  Number field.', Comment = '%';
                }
                field("student Name "; Rec."student Name ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student Name field.', Comment = '%';
                }
                field("student Email"; Rec."student Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student Email field.', Comment = '%';
                }
                field("student phone number"; Rec."student phone number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student phone number field.', Comment = '%';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.', Comment = '%';
                }
                field("damage cost "; Rec."damage cost ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the damage cost field.', Comment = '%';
                }
                field("dvc comment "; Rec."dvc comment ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dvc comment field.', Comment = '%';
                }
                field("finance comment "; Rec."finance comment ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the finance comment field.', Comment = '%';
                }

            }
        }
    }
}
