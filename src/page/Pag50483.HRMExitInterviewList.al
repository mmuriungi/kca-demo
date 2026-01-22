page 50483 "HRM-Exit Interview List"
{
    CardPageID = "HRM-Emp. Exit Requisition";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Employee Exit Interviews";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Exit Clearance No"; Rec."Exit Clearance No")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Date Of Clearance"; Rec."Date Of Clearance")
                {
                    Importance = Promoted;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Interview Done By"; Rec."Clearer Name")
                {
                }
                field("Nature Of Separation"; Rec."Nature Of Separation")
                {
                    Importance = Promoted;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    Importance = Promoted;
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

