page 50061 "ACA-2ndSupp. Results Status"
{
    ApplicationArea = All;
    Caption = 'ACA-2ndSupp. Results Status';
    PageType = List;
    SourceTable = "ACA-2ndSupp. Results Status";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order No field.';
                }
                field("Minimum Units Failed"; Rec."Minimum Units Failed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Units Failed field.';
                }
                field("Maximum Units Failed"; Rec."Maximum Units Failed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Units Failed field.';
                }

                field("Transcript Remarks"; Rec."Transcript Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transcript Remarks field.';
                }
                field("Lead Status"; Rec."Lead Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lead Status field.';
                }
                field("Manual Status Processing"; Rec."Manual Status Processing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manual Status Processing field.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Special Programme Class"; Rec."Special Programme Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Programme Class field.';
                }
                field("Skip Supp Generation"; Rec."Skip Supp Generation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Skip Supp Generation field.';
                }
            }
        }
    }
}
