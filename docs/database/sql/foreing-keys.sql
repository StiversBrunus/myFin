--------------------------------------------------
-- FOREIGN KEYS
--------------------------------------------------

ALTER TABLE reserve
ADD CONSTRAINT fk_reserve_wallet
FOREIGN KEY (wallet_id)
REFERENCES wallet(id);

ALTER TABLE goal
ADD CONSTRAINT fk_goal_reserve
FOREIGN KEY (reserve_id)
REFERENCES reserve(id);

ALTER TABLE investment 
ADD CONSTRAINT fk_investment_bank
FOREIGN KEY (bank_id)
REFERENCES bank(id);

ALTER TABLE investment
ADD CONSTRAINT fk_investment_investment_type
FOREIGN KEY (investment_type_id)
REFERENCES investment_type(id);

ALTER TABLE investment_transaction 
ADD CONSTRAINT fk_investment_transaction_goal
FOREIGN KEY (goal_id)
REFERENCES goal(id);

ALTER TABLE investment_transaction
ADD CONSTRAINT fk_investment_transaction_investment
FOREIGN KEY (investment_id)
REFERENCES investment(id);