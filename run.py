# coding: utf-8

from slacker import Slacker
import slackbot_settings
from slackbot.bot import Bot
import logging
import os

def main():
    bot = Bot()
    bot.run()

if __name__ == "__main__":
    loglevel = os.getenv("LOG_LEVEL", "WARNING")
    num_level = getattr(logging, loglevel.upper(),None)
    if not isinstance(num_level, int):
        raise ValueError('Invalid log level: %s' % loglevel)
    logging.basicConfig(level=num_level,
                        format='%(asctime)s- %(name)s - %(levelname)s - %(message)s')
    slack = Slacker(slackbot_settings.API_TOKEN)
    slack.chat.post_message(
        'general',
        'こんにちわー',
        as_user=True
        )
    logger = logging.getLogger(__name__)
    logger.info('start slackbot')
    main()

