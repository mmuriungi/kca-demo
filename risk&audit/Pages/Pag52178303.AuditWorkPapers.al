page 52178303 "Audit Work Papers"
{
    CardPageID = "Audit Working Paper";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Work Paper"), Archived = FILTER(false), Reviewed = FILTER(false), Status = filter(Open));
    //
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Created By"; "Created By")
                {
                }
                field(Status; Status)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::"Work Paper";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Work Paper";
    end;

    procedure GetSelectionFilter(): Text
    var
        AuditHeader: Record "Audit Header";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(AuditHeader);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForWorkingPapers(AuditHeader));
    end;

    local procedure SelectInItemList(var Audit: Record "Audit Header"): Text
    var
        AuditWorkpapers: Page "Reviewed Audit Work Papers";
    begin
        AuditWorkpapers.SETTABLEVIEW(Audit);
        AuditWorkpapers.LOOKUPMODE(TRUE);
        IF AuditWorkpapers.RUNMODAL = ACTION::LookupOK THEN
            EXIT(AuditWorkpapers.GetSelectionFilter);
    end;

    procedure SelectActiveWorkpapersForReport(): Text
    var
        Audit: Record "Audit Header";
    begin
        EXIT(SelectInItemList(Audit));
    end;
}

