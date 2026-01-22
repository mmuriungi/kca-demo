page 52133 "Timetable Change Log"
{
    Caption = 'Timetable Change Log';
    PageType = List;
    SourceTable = "Timetable Change Log";
    UsageCategory = History;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number.';
                }
                field("Change Date"; Rec."Change Date")
                {
                    ToolTip = 'Specifies when the change was made.';
                }
                field("Change Time"; Rec."Change Time")
                {
                    ToolTip = 'Specifies the time when the change was made.';
                }
                field("Change Type"; Rec."Change Type")
                {
                    ToolTip = 'Specifies the type of change.';
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the programme code.';
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ToolTip = 'Specifies the stage code.';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the unit code.';
                }
                field("Stream"; Rec.Stream)
                {
                    ToolTip = 'Specifies the stream.';
                }
                field("Change Description"; Rec."Change Description")
                {
                    ToolTip = 'Specifies the description of the change.';
                }
                field("Old Lecturer Code"; Rec."Old Lecturer Code")
                {
                    ToolTip = 'Specifies the old lecturer code.';
                    Visible = ShowLecturerChanges;
                }
                field("New Lecturer Code"; Rec."New Lecturer Code")
                {
                    ToolTip = 'Specifies the new lecturer code.';
                    Visible = ShowLecturerChanges;
                }
                field("Old Room Code"; Rec."Old Room Code")
                {
                    ToolTip = 'Specifies the old room code.';
                    Visible = ShowRoomChanges;
                }
                field("New Room Code"; Rec."New Room Code")
                {
                    ToolTip = 'Specifies the new room code.';
                    Visible = ShowRoomChanges;
                }
                field("Old Day"; Rec."Old Day")
                {
                    ToolTip = 'Specifies the old day.';
                    Visible = ShowTimeChanges;
                }
                field("New Day"; Rec."New Day")
                {
                    ToolTip = 'Specifies the new day.';
                    Visible = ShowTimeChanges;
                }
                field("Old Start Time"; Rec."Old Start Time")
                {
                    ToolTip = 'Specifies the old start time.';
                    Visible = ShowTimeChanges;
                }
                field("New Start Time"; Rec."New Start Time")
                {
                    ToolTip = 'Specifies the new start time.';
                    Visible = ShowTimeChanges;
                }
                field("Old End Time"; Rec."Old End Time")
                {
                    ToolTip = 'Specifies the old end time.';
                    Visible = ShowTimeChanges;
                }
                field("New End Time"; Rec."New End Time")
                {
                    ToolTip = 'Specifies the new end time.';
                    Visible = ShowTimeChanges;
                }
                field("Change Reason"; Rec."Change Reason")
                {
                    ToolTip = 'Specifies the reason for the change.';
                }
                field("Changed By"; Rec."Changed By")
                {
                    ToolTip = 'Specifies who made the change.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Filter by Lecturer Changes")
            {
                ApplicationArea = All;
                Caption = 'Show Lecturer Changes';
                Image = Filter;
                trigger OnAction()
                begin
                    Rec.SetRange("Change Type", Rec."Change Type"::"Lecturer Change");
                    CurrPage.Update(false);
                end;
            }
            action("Filter by Room Changes")
            {
                ApplicationArea = All;
                Caption = 'Show Room Changes';
                Image = Filter;
                trigger OnAction()
                begin
                    Rec.SetRange("Change Type", Rec."Change Type"::"Room Change");
                    CurrPage.Update(false);
                end;
            }
            action("Filter by Time Changes")
            {
                ApplicationArea = All;
                Caption = 'Show Time Changes';
                Image = Filter;
                trigger OnAction()
                begin
                    Rec.SetRange("Change Type", Rec."Change Type"::"Time Change");
                    CurrPage.Update(false);
                end;
            }
            action("Clear Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear All Filters';
                Image = ClearFilter;
                trigger OnAction()
                begin
                    Rec.Reset();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Processing)
        {
            action("Print Change Log")
            {
                ApplicationArea = All;
                Caption = 'Print Change Log';
                Image = Print;
                trigger OnAction()
                begin
                    // TODO: Create report for change log
                    Message('Change log report will be created to print detailed change history.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UpdateFieldVisibility();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateFieldVisibility();
    end;

    local procedure UpdateFieldVisibility()
    begin
        ShowLecturerChanges := false;
        ShowRoomChanges := false;
        ShowTimeChanges := false;

        // Show relevant fields based on change types in current view
        if Rec.FindSet() then begin
            repeat
                case Rec."Change Type" of
                    Rec."Change Type"::"Lecturer Change":
                        ShowLecturerChanges := true;
                    Rec."Change Type"::"Room Change":
                        ShowRoomChanges := true;
                    Rec."Change Type"::"Time Change":
                        ShowTimeChanges := true;
                end;
            until (Rec.Next() = 0) or (ShowLecturerChanges and ShowRoomChanges and ShowTimeChanges);
        end;
    end;

    var
        ShowLecturerChanges: Boolean;
        ShowRoomChanges: Boolean;
        ShowTimeChanges: Boolean;
}