from pydantic_settings import BaseSettings
from functools import lru_cache
from typing import Optional
import secrets


class Settings(BaseSettings):
    APP_NAME: str = "KeyWordNoteBook API"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = False

    DATABASE_URL: str = "sqlite:///./keybook.db"

    JWT_SECRET_KEY: str = ""

    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7

    CORS_ALLOWED_ORIGINS: str = ""

    RATE_LIMIT_ENABLED: bool = True
    RATE_LIMIT_PER_MINUTE: int = 60

    ARGON2_MEMORY_COST: int = 131072
    ARGON2_TIME_COST: int = 6
    ARGON2_PARALLELISM: int = 6
    ARGON2_HASH_LEN: int = 64

    TRUSTED_HOSTS: str = ""

    class Config:
        env_file = ".env"
        extra = "allow"

    def validate(self):
        if self.JWT_SECRET_KEY == "":
            if not self.DEBUG:
                raise ValueError("JWT_SECRET_KEY must be set in production (non-debug mode)")
        elif len(self.JWT_SECRET_KEY) < 32:
            raise ValueError("JWT_SECRET_KEY must be at least 32 characters long")
        return True


@lru_cache()
def get_settings() -> Settings:
    settings = Settings()
    settings.validate()
    return settings
