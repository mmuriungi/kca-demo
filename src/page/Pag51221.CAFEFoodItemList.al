page 51221 "CAFE Food Item List"
{
    Caption = 'Item List';
    CardPageID = "CAFE Food Item Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    SourceTable = Item;
    SourceTableView = WHERE("Item Category Code" = FILTER('FOOD'));

    layout
    {
        area(content)
        {
            repeater(Item)
            {
                Caption = 'Item';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.';
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = true;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit in which the item is held in inventory.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost per unit of the item.';
                    Visible = false;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    Visible = false;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    Visible = false;
                }
                field("Profit %"; Rec."Profit %")
                {
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price for one unit of the item, in $.';
                    Visible = false;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part("Item Invoicing FactBox"; "Item Invoicing FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
            }
            part("Item Replenishment FactBox"; "Item Replenishment FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = false;
            }
            // part("Item Planning FactBox";"Item Planning FactBox")
            // {
            //     SubPageLink = "No."=FIELD("No."),
            //                   "Date Filter"=FIELD("Date Filter"),
            //                   "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
            //                   "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
            //                   "Location Filter"=FIELD("Location Filter"),
            //                   "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
            //                   "Bin Filter"=FIELD("Bin Filter"),
            //                   "Variant Filter"=FIELD("Variant Filter"),
            //                  " Lot No. Filter"=FIELD("Lot No. Filter"),
            //                   "Serial No. Filter"=FIELD("Serial No. Filter");
            // }
            part(ItemAttributesFactBox; 9110)
            {
                ApplicationArea = Basic, Suite;
            }
            // systempart(;Links)
            // {
            // }
            // systempart(;Notes)
            // {
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group(Itemz)
            {
                Caption = 'Item';
                Image = DataEntry;
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    Scope = Repeater;
                    ToolTip = 'Set up the different units that the selected item can be traded in, such as piece, box, or hour.';
                }
                action(Attributes)
                {
                    AccessByPermission = TableData 7500 = R;
                    Caption = 'Attributes';
                    Image = Category;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Scope = Repeater;
                    ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(PAGE::"Item Attribute Value Editor", Rec);
                        CurrPage.SAVERECORD;
                        CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData(Rec."No.");
                    end;
                }

                action(ClearAttributes)
                {
                    AccessByPermission = TableData 7500 = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Clear Attributes Filter';
                    Image = RemoveFilterLines;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedOnly = true;
                    ToolTip = 'Remove the filter for specific item attributes.';

                    // trigger OnAction()
                    // begin
                    //     TempFilterItemAttributesBuffer.RESET;
                    //     TempFilterItemAttributesBuffer.DELETEALL;
                    //     FILTERGROUP(0);
                    //     SETRANGE("No.");
                    // end;
                }
                action("Cross Re&ferences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    //RunObject = Page "Item Cross Reference Entries";
                    //RunPageLink = "Item No." = FIELD("No.");
                    Scope = Repeater;
                    ToolTip = 'Set up a customer''s or vendor''s own identification of the selected item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
                }
                action("E&xtended Text")
                {
                    Caption = 'E&xtended Text';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    Scope = Repeater;
                    ToolTip = 'Set up additional text for the description of the selected item. Extended text can be inserted under the Description field on document lines for the item.';
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No."),
                                  "Variant Code" = CONST();
                    Scope = Repeater;
                    ToolTip = 'Set up translated item descriptions for the selected item. Translated item descriptions are automatically inserted on documents according to the language code.';
                }
                group(rtryt)
                {
                    Visible = false;
                    action(AdjustInventory)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Inventory';
                        Enabled = InventoryItemEditable;
                        Image = InventoryCalculation;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedOnly = true;
                        Scope = Repeater;
                        ToolTip = 'Increase or decrease the item''s inventory quantity manually by entering a new quantity. Adjusting the inventory quantity manually may be relevant after a physical count or if you do not record purchased quantities.';
                        Visible = IsFoundationEnabled;

                        trigger OnAction()
                        begin
                            COMMIT;
                            PAGE.RUNMODAL(PAGE::"Adjust Inventory", Rec)
                        end;
                    }
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(27),
                                      "No." = FIELD("No.");
                        Scope = Repeater;
                        ShortCutKey = 'Shift+Ctrl+D';
                    }

                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.")
                                      ORDER(Descending);
                        Scope = Repeater;
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the history of positive and negative inventory changes that reflect transactions with the selected item.';
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        Scope = Repeater;
                    }
                }
            }
            group(PricesandDiscounts)
            {
                Caption = 'Prices and Discounts';
                action(Prices_Prices)
                {
                    Caption = 'Special Prices';
                    Image = Price;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    Scope = Repeater;
                    ToolTip = 'Set up different prices for the selected item. An item price is automatically used on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }
                action(Prices_LineDiscounts)
                {
                    Caption = 'Special Discounts';
                    Image = LineDiscount;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item),
                                  Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    Scope = Repeater;
                    ToolTip = 'Set up different discounts for the selected item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                }

                action("Sales Price Worksheet")
                {
                    Caption = 'Sales Price Worksheet';
                    Image = PriceWorksheet;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page 7023;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                action("Adjust Cost - Item Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjust Cost - Item Entries';
                    Image = AdjustEntries;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Report 795;
                    ToolTip = 'Adjust inventory values in value entries so that you use the correct adjusted cost for updating the general ledger and so that sales and profit statistics are up to date.';
                }
                action("Post Inventory Cost to G/L")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Report 1002;
                    ToolTip = 'Post the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }
                action("Physical Inventory Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Physical Inventory Journal';
                    Image = PhysicalInventory;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Page 392;
                    ToolTip = 'Select how you want to maintain an up-to-date record of your inventory at different locations.';
                }
                action("Revaluation Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Revaluation Journal';
                    Image = Journal;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category8;
                    RunObject = Page 5803;
                    ToolTip = 'View or edit the inventory value of items, which you can change, such as after doing a physical inventory.';
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;

            }


            action("Requisition Worksheet")
            {
                Caption = 'Requisition Worksheet';
                Image = Worksheet;
                RunObject = Page 291;
            }
            action("Item Journal")
            {
                Caption = 'Item Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 40;
            }
            action("Item Reclassification Journal")
            {
                Caption = 'Item Reclassification Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 393;
            }
            action("Item Tracing")
            {
                Caption = 'Item Tracing';
                Image = ItemTracing;
                RunObject = Page 6520;
            }
            action("Adjust Item Cost/Price")
            {
                Caption = 'Adjust Item Cost/Price';
                Image = AdjustItemCost;
                RunObject = Report 794;
            }
        }
        area(reporting)
        {
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                action("Assemble to Order - Sales")
                {
                    Caption = 'Assemble to Order - Sales';
                    Image = "Report";
                    RunObject = Report 915;
                }
                action("Where-Used (Top Level)")
                {
                    Caption = 'Where-Used (Top Level)';
                    Image = "Report";
                    RunObject = Report 99000757;
                }
                action("Quantity Explosion of BOM")
                {
                    Caption = 'Quantity Explosion of BOM';
                    Image = "Report";
                    RunObject = Report 99000753;
                }
                // action("Issue History")
                // {
                //     Caption = 'Issue History';
                //     Image = "Report";
                //     Promoted = false;
                //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //     //PromotedCategory = "Report";
                //     RunObject = Report 10140;
                // }
                group(Costing)
                {
                    Caption = 'Costing';
                    Image = ItemCosts;
                    action("Inventory Valuation - WIP")
                    {
                        Caption = 'Inventory Valuation - WIP';
                        Image = "Report";
                        RunObject = Report 5802;
                    }
                    action("Cost Shares Breakdown")
                    {
                        Caption = 'Cost Shares Breakdown';
                        Image = "Report";
                        RunObject = Report 5848;
                    }
                    action("Detailed Calculation")
                    {
                        Caption = 'Detailed Calculation';
                        Image = "Report";
                        RunObject = Report 99000756;
                    }
                    action("Rolled-up Cost Shares")
                    {
                        Caption = 'Rolled-up Cost Shares';
                        Image = "Report";
                        RunObject = Report 99000754;
                    }
                    action("Single-Level Cost Shares")
                    {
                        Caption = 'Single-Level Cost Shares';
                        Image = "Report";
                        RunObject = Report 99000755;
                    }
                }


                action("Inventory - Reorders")
                {
                    Caption = 'Inventory - Reorders';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 717;
                }
                action("Inventory - Sales Back Orders")
                {
                    Caption = 'Inventory - Sales Back Orders';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report 718;
                }

            }
        }
        area(navigation)
        {

            group(Availability)
            {
                Caption = 'Availability';
                Image = Item;
                action("Items b&y Location")
                {
                    AccessByPermission = TableData 14 = R;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ToolTip = 'Show a list of items grouped by location.';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Items by Location", Rec);
                    end;
                }
                // group("&Item Availability by")
                // {
                //     Caption = '&Item Availability by';
                //     Image = ItemAvailability;
                //     action(Timeline)
                //     {
                //         Caption = 'Timeline';
                //         Image = Timeline;

                //         trigger OnAction()
                //         begin
                //             Rec.ShowTimelineFromItem(Rec);
                //         end;
                //     }
                // }
            }

        }
    }


    var
        // TempFilterItemAttributesBuffer: Record "7506" temporary;
        // ApplicationAreaSetup: Record "9178";
        // CalculateStdCost: Codeunit "5812";
        // ItemAvailFormsMgt: Codeunit "353";
        // ApprovalsMgmt: Codeunit "1535";
        // SkilledResourceList: Page "6023";
        IsFoundationEnabled: Boolean;
        [InDataSet]
        SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        [InDataSet]
        IsService: Boolean;
        [InDataSet]
        InventoryItemEditable: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;

    // procedure GetSelectionFilter(): Text
    // var
    //     Item: Record "27";
    //     SelectionFilterManagement: Codeunit "46";
    // begin
    //     CurrPage.SETSELECTIONFILTER(Item);
    //     EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    // end;

    // procedure SetSelection(var Item: Record "27")
    // begin
    //     CurrPage.SETSELECTIONFILTER(Item);
    // end;

    // local procedure SetSocialListeningFactboxVisibility()
    // var
    //     SocialListeningMgt: Codeunit "871";
    // begin
    //     SocialListeningMgt.GetItemFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    // end;

    local procedure EnableControls()
    begin
        IsService := (Rec.Type = Rec.Type::Service);
        InventoryItemEditable := Rec.Type = Rec.Type::Inventory;
    end;

    trigger OnOpenPage()
    begin
        // UserSetup.RESET;
        // UserSetup.SETRANGE("User ID", USERID);
        // IF NOT UserSetup.FINDFIRST THEN ERROR('Access denied!');
        // IF UserSetup."can add Invenory" = FALSE THEN ERROR('Access denied!');
    end;


    var
        UserSetup: Record "ACA-Hostel Permissions";

    // local procedure SetWorkflowManagementEnabledState()
    // var
    //     WorkflowManagement: Codeunit "1501";
    //     WorkflowEventHandling: Codeunit "1520";
    // begin
    //     EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode + '|' +
    //       WorkflowEventHandling.RunWorkflowOnItemChangedCode;

    //     EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item,EventFilter);
    // end;
}

