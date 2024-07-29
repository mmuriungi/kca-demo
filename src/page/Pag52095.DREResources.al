page 52095 "DRE-Resources"
{
    Caption = 'DRE-Resources';
    PageType = List;
    SourceTable = "DRE-Resources";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Resource No"; Rec."Resource No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource No field.';
                }
                field("Resource Type"; Rec."Resource Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Type field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Resource Cost"; Rec."Resource Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Cost field.';
                }
                field("Date of Intallation"; Rec."Date of Intallation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Intallation field.';
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specialization field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Active Projects"; Rec."Active Projects")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}
