xmlport 50014 "Gen Journal Import"
{
    Caption = 'Gen Journal Import';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                //journalname
                fieldelement(JournalName; GenJournalLine."Journal Template Name")
                {
                }
                fieldelement(JournalBatchName; GenJournalLine."Journal Batch Name")
                {
                }

                fieldelement(LineNo; GenJournalLine."Line No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }

                fieldelement(Description; GenJournalLine.Description)
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }
                fieldelement(ShortcutDimension1Code; GenJournalLine."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ShortcutDimension2Code; GenJournalLine."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(ExternalDocumentNo; GenJournalLine."External Document No.")
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
