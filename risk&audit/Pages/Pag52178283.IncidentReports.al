page 52178283 "Incident Reports"
{
    Caption = 'Incidences';
    CardPageID = "Incident Report";
    PageType = List;
    SourceTable = "User Support Incident";
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; "Incident Reference")
                {
                    Caption = 'No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; "Incident Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Date"; "Incident Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; "Incident Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::AUDIT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::AUDIT;
    end;

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                FilterGroup(2);
                SetRange(User, UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        UserSetup: Record "User Setup";

}