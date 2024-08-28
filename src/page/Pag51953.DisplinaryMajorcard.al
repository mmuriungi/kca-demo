page 51953 "Displinary Major card"
{
    SourceTable = "Displinary Cases";
    PageType = Card;
    SourceTableView = where("Case Status" = filter(Supervisor));
    layout
    {
        area(Content)
        {
            Group(general)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec."Type" := Rec."Type"::Major;
                    end;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Offence Identified"; Rec."Offence Identified")
                {
                    ToolTip = 'Specifies the value of the Offence Identified field.';
                    ApplicationArea = All;
                }
                field("Offence Description"; Rec."Offence Description")
                {
                    ToolTip = 'Specifies the value of the Offence Description field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Show Cause Letter"; Rec."Show Cause Letter")
                {
                    ToolTip = 'Specifies the value of the Show Cause Letter field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("1st Committee Identified"; Rec."1st Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 1st Committee Identified field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("JSAC/SSACS Committee"; Rec."JSAC/SSACS Committee")
                {
                    ToolTip = 'Specifies the value of the JSAC/SSACS Committee field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Date Reported"; Rec."Date Reported")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send to DDHR")
            {
                Caption = 'Send to DDHR';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::"Fowarded to DDHR";
                end;

            }
        }

    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Type" := Rec."Type"::Major;
    end;
}