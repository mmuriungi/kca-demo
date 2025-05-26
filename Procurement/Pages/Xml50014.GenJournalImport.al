xmlport 50014 "Gen Journal Import"
{
    Caption = 'Gen Journal Import';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(LineNo; GenJournalLine."Line No.")
                {
                }
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(Description; GenJournalLine.Description)
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }
                fieldelement(ExternalDocumentNo; GenJournalLine."External Document No.")
                {
                }
                fieldelement(ShortcutDimension1Code; GenJournalLine."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ShortcutDimension2Code; GenJournalLine."Shortcut Dimension 2 Code")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
