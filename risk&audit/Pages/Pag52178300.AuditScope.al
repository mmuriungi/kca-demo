page 50197 "Audit Scope"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scope Selected"; Rec."Scope Selected")
                {
                }
                field(Scope; DNotesText)
                {

                    trigger OnValidate()
                    begin

                        Rec.CALCFIELDS(Description);
                        Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);

                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Rec.Description);
                            CLEAR(DNotes);
                            DNotes.ADDTEXT(DNotesText);
                            Description.CREATEOUTSTREAM(OutStr);
                            DNotes.WRITE(OutStr);
                        END;
                    end;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin

        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;

    procedure GetSelectionFilter(): Text
    var
        AuditLine: Record "Audit Lines";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(AuditLine);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForProgramScope(AuditLine));
    end;

    local procedure SelectInScopeListPart(var AuditLine: Record "Audit Lines"): Text
    var
        AuditProgScope: Page "Audit Scope";
    begin
        AuditProgScope.SETTABLEVIEW(AuditLine);
        AuditProgScope.LOOKUPMODE(TRUE);
        IF AuditProgScope.RUNMODAL = ACTION::LookupOK THEN
            EXIT(AuditProgScope.GetSelectionFilter);
    end;

    procedure SelectActiveScopeForWorkpaper(AuditHeader: Record "Audit Header"): Text
    var
        AuditLine: Record "Audit Lines";
    begin
        AuditLine.RESET;
        AuditLine.SETRANGE("Document No.", AuditHeader."Audit Program No.");
        AuditLine.SETRANGE("Audit Line Type", AuditLine."Audit Line Type"::Scope);
        EXIT(SelectInScopeListPart(AuditLine));
    end;
}

