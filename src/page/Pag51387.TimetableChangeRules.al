page 52134 "Timetable Change Rules"
{
    Caption = 'Timetable Change Rules';
    PageType = List;
    SourceTable = "Timetable Change Rule";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number.';
                    Visible = false;
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies if this rule is active.';
                }
                field("Rule Type"; Rec."Rule Type")
                {
                    ToolTip = 'Specifies the type of change this rule will apply.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description for this rule.';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the priority order for applying rules.';
                }
                field("Apply To"; Rec."Apply To")
                {
                    ToolTip = 'Specifies if the rule applies to specific entries or all matching criteria.';
                }
                field("Change Reason"; Rec."Change Reason")
                {
                    ToolTip = 'Specifies the reason for this change.';
                }
                field(Applied; Rec.Applied)
                {
                    ToolTip = 'Indicates if this rule has been applied.';
                    Editable = false;
                    StyleExpr = AppliedStyle;
                }
                field("Entries Affected"; Rec."Entries Affected")
                {
                    ToolTip = 'Shows how many entries were affected by this rule.';
                    Editable = false;
                }
            }
            group(Filters)
            {
                Caption = 'Filter Criteria';
                field("Filter Programme"; Rec."Filter Programme")
                {
                    ToolTip = 'Filter by programme code.';
                }
                field("Filter Stage"; Rec."Filter Stage")
                {
                    ToolTip = 'Filter by stage.';
                }
                field("Filter Unit"; Rec."Filter Unit")
                {
                    ToolTip = 'Filter by unit code.';
                }
                field("Filter Stream"; Rec."Filter Stream")
                {
                    ToolTip = 'Filter by stream.';
                }
                field("Filter Lecturer"; Rec."Filter Lecturer")
                {
                    ToolTip = 'Filter by lecturer.';
                }
                field("Filter Room"; Rec."Filter Room")
                {
                    ToolTip = 'Filter by room.';
                }
                field("Filter Day"; Rec."Filter Day")
                {
                    ToolTip = 'Filter by day of week.';
                }
                field("Filter Time Slot"; Rec."Filter Time Slot")
                {
                    ToolTip = 'Filter by time slot.';
                }
                field("Filter Date From"; Rec."Filter Date From")
                {
                    ToolTip = 'Filter from date.';
                }
                field("Filter Date To"; Rec."Filter Date To")
                {
                    ToolTip = 'Filter to date.';
                }
            }
            group("Actions")
            {
                Caption = 'Change Actions';
                field("New Lecturer"; Rec."New Lecturer")
                {
                    ToolTip = 'Specifies the new lecturer for lecturer change rules.';
                    Visible = ShowLecturerFields;
                }
                field("New Room"; Rec."New Room")
                {
                    ToolTip = 'Specifies the new room for room change rules.';
                    Visible = ShowRoomFields;
                }
                field("New Day"; Rec."New Day")
                {
                    ToolTip = 'Specifies the new day for time change rules.';
                    Visible = ShowTimeFields;
                }
                field("New Time Slot"; Rec."New Time Slot")
                {
                    ToolTip = 'Specifies the new time slot for time change rules.';
                    Visible = ShowTimeFields;
                }
                field("New Stream"; Rec."New Stream")
                {
                    ToolTip = 'Specifies the new stream for stream reassignment rules.';
                    Visible = ShowStreamFields;
                }
                field("Cancel Unit"; Rec."Cancel Unit")
                {
                    ToolTip = 'Specifies if the unit should be cancelled.';
                    Visible = ShowCancelFields;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Validate Rule")
            {
                ApplicationArea = All;
                Caption = 'Validate Rule';
                Image = CheckRulesSyntax;
                trigger OnAction()
                var
                    ChangeMgt: Codeunit "Timetable Change Management";
                begin
                    if ChangeMgt.ValidateChangeRule(Rec) then
                        Message('Rule is valid and ready to apply.');
                end;
            }
            action("Preview Changes")
            {
                ApplicationArea = All;
                Caption = 'Preview Changes';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ChangeMgt: Codeunit "Timetable Change Management";
                    AffectedCount: Integer;
                begin
                    Rec.TestField("Timetable Document No.");
                    Rec.TestField(Active, true);
                    
                    AffectedCount := ChangeMgt.GetAffectedEntriesCount(Rec);
                    if Confirm('This rule will affect %1 entries. Do you want to see a detailed preview?', true, AffectedCount) then begin
                        // Show affected entries
                        ShowAffectedEntries();
                    end;
                end;
            }
            action("Apply Rule")
            {
                ApplicationArea = All;
                Caption = 'Apply Rule';
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ChangeMgt: Codeunit "Timetable Change Management";
                    ChangeRule: Record "Timetable Change Rule";
                begin
                    Rec.TestField("Timetable Document No.");
                    Rec.TestField(Active, true);
                    Rec.TestField(Applied, false);
                    
                    if ChangeMgt.ValidateChangeRule(Rec) then begin
                        ChangeRule.Copy(Rec);
                        ChangeRule.SetRecFilter();
                        ChangeMgt.ProcessChangeRules(Rec."Timetable Document No.", false);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action("Apply All Active Rules")
            {
                ApplicationArea = All;
                Caption = 'Apply All Active Rules';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ChangeMgt: Codeunit "Timetable Change Management";
                begin
                    if Confirm('This will apply all active, unapplied rules. Continue?', false) then begin
                        ChangeMgt.ProcessChangeRules(Rec."Timetable Document No.", false);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
        area(Navigation)
        {
            action("Show Change Log")
            {
                ApplicationArea = All;
                Caption = 'Show Change Log';
                Image = Log;
                trigger OnAction()
                var
                    ChangeLog: Record "Timetable Change Log";
                begin
                    ChangeLog.SetRange("Timetable Document No.", Rec."Timetable Document No.");
                    Page.RunModal(52133, ChangeLog);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateFieldVisibility();
        SetAppliedStyle();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Priority := 100;
        Rec.Active := true;
        UpdateFieldVisibility();
    end;

    local procedure UpdateFieldVisibility()
    begin
        ShowLecturerFields := Rec."Rule Type" = Rec."Rule Type"::"Lecturer Change";
        ShowRoomFields := Rec."Rule Type" = Rec."Rule Type"::"Room Change";
        ShowTimeFields := Rec."Rule Type" = Rec."Rule Type"::"Time Change";
        ShowStreamFields := Rec."Rule Type" = Rec."Rule Type"::"Stream Reassignment";
        ShowCancelFields := Rec."Rule Type" = Rec."Rule Type"::"Unit Cancellation";
    end;

    local procedure SetAppliedStyle()
    begin
        if Rec.Applied then
            AppliedStyle := 'Favorable'
        else
            AppliedStyle := '';
    end;

    local procedure ShowAffectedEntries()
    var
        TimetableEntry: Record "Timetable Entry";
        TempTimetableEntry: Record "Timetable Entry" temporary;
    begin
        // Build the same filter as in the codeunit
        TimetableEntry.SetRange("Document No.", Rec."Timetable Document No.");
        
        if Rec."Filter Programme" <> '' then
            TimetableEntry.SetRange("Programme Code", Rec."Filter Programme");
        if Rec."Filter Stage" <> '' then
            TimetableEntry.SetRange("Stage Code", Rec."Filter Stage");
        if Rec."Filter Unit" <> '' then
            TimetableEntry.SetRange("Unit Code", Rec."Filter Unit");
        if Rec."Filter Stream" <> '' then
            TimetableEntry.SetRange("Group No", Rec."Filter Stream");
        if Rec."Filter Lecturer" <> '' then
            TimetableEntry.SetRange("Lecturer Code", Rec."Filter Lecturer");
        if Rec."Filter Room" <> '' then
            TimetableEntry.SetRange("Lecture Hall Code", Rec."Filter Room");
        if Rec."Filter Day" <> 0 then
            TimetableEntry.SetRange("Day of Week", Rec."Filter Day" - 1);
        if Rec."Filter Time Slot" <> '' then
            TimetableEntry.SetRange("Time Slot Code", Rec."Filter Time Slot");
            
        if TimetableEntry.FindSet() then begin
            repeat
                TempTimetableEntry := TimetableEntry;
                TempTimetableEntry.Insert();
            until TimetableEntry.Next() = 0;
        end;
        
        Page.RunModal(Page::"Timetable Entry", TempTimetableEntry);
    end;

    var
        ShowLecturerFields: Boolean;
        ShowRoomFields: Boolean;
        ShowTimeFields: Boolean;
        ShowStreamFields: Boolean;
        ShowCancelFields: Boolean;
        AppliedStyle: Text;
}