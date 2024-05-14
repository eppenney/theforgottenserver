/*
	Q4 - Assume all method calls work fine. Fix the memory leak issue in below method
*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);

	if (!player) {
		player = new Player(nullptr);
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			delete player; // Free up memory allocated to player ptr
			return;
		}
	}

	Item* item = Item::CreateItem(itemId); // Create item method should be responsible for allocation / deallocation
	if (!item) {
		delete player; // Free up memory allocated to player ptr
		return; 
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	if (player->isOffline()) {
		IOLoginData::savePlayer(player);
	}

	// If the player was not found within game, delete the instance created earlier
	if (!g_game.getPlayerByName(recipient)) {
        delete player;
    }
}
