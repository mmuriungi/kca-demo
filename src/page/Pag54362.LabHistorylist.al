page 54362 "Lab History list"
{
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;

    CardPageId = "HMS-Treatment Lab History";
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = where("Lab Status" = filter(Cleared));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                    ApplicationArea = All;
                }
                field("Date"; Rec."Treatment Date")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                    ApplicationArea = All;
                }
                field("Patient No."; rec."Patient No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                    ApplicationArea = All;
                }
                field("Lab Status"; Rec."Lab Status")
                {
                    ToolTip = 'Specifies the value of the Lab Status field.';
                    ApplicationArea = All;
                }
                field("Sent to Lab"; Rec."sent to lab")
                {
                    ToolTip = 'Specifies the value of the Lab Status field.';
                    ApplicationArea = All;
                }
                field("Observation No."; Rec."Observation No.")
                {
                    ToolTip = 'Specifies the value of the Observation No. field.';
                    ApplicationArea = All;
                }

                field("Treatment Type"; Rec."Treatment Type")
                {
                    ToolTip = 'Specifies the value of the Treatment Type field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}