page 55720 "Displinary Major DDHR Tabling"
{
    PageType = List;
    Editable = false;
    SourceTable = "Displinary Cases";
    CardPageId = "Displinary Major DDHR TablingC";
    SourceTableView = where("Case Status" = filter("Fowarded to DDHR_T"));

    layout
    {
        area(Content)
        {
            repeater(general)
            {


                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
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
                    Visible = false;
                }
                field("Show Cause Letter"; Rec."Show Cause Letter")
                {
                    ToolTip = 'Specifies the value of the Show Cause Letter field.';
                    ApplicationArea = All;
                }
                field("Show Cause Response"; Rec."Show Cause Response")
                {
                    ToolTip = 'Specifies the value of the Show Cause Response field.';
                    ApplicationArea = All;
                }
                field("1st Committee Identified"; Rec."1st Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 1st Committee Identified field.';
                    ApplicationArea = All;
                }
                field("JSAC/SSACS Committee"; Rec."JSAC/SSACS Committee")
                {
                    ToolTip = 'Specifies the value of the JSAC/SSACS Committee field.';
                    ApplicationArea = All;
                }
                field("Full Board"; Rec."Full Board")
                {
                    ToolTip = 'Specifies the value of the Full Board field.';
                    ApplicationArea = All;
                }
                field("Suspend Staff"; Rec."Suspend Staff")
                {
                    ToolTip = 'Specifies the value of the Suspend Staff field.';
                    ApplicationArea = All;
                }
                field(Investigation; Rec.Investigation)
                {
                    ToolTip = 'Specifies the value of the Investigation field.';
                    ApplicationArea = All;
                }
                field("Displinary Case"; Rec."Displinary Case")
                {
                    ToolTip = 'Specifies the value of the Displinary Case field.';
                    ApplicationArea = All;
                }
                field("Formal Hearing"; Rec."Formal Hearing")
                {
                    ToolTip = 'Specifies the value of the Formal Hearing field.';
                    ApplicationArea = All;
                }
                field("Formal Hearing Committee"; Rec."Formal Hearing Committee")
                {
                    ToolTip = 'Specifies the value of the Formal Hearing Committee field.';
                    ApplicationArea = All;
                }
                field("2nd Committee Identified"; Rec."2nd Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 2nd Committee Identified field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
