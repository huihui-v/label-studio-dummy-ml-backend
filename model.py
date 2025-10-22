import logging
import os

from uuid import uuid4
from typing import List, Dict, Optional

from label_studio_ml.model import LabelStudioMLBase

logger = logging.getLogger(__name__)


class DummyModel(LabelStudioMLBase):
    """
    A simple dummy model that always returns 1 for any input.
    Minimal implementation without unnecessary logic.
    """

    def setup(self):
        """Initialize the model"""
        self.set("model_version", f'{self.__class__.__name__}-v0.0.1')

    def predict(self, tasks: List[Dict], context: Optional[Dict] = None, **kwargs) -> List[Dict]:
        """
        Dummy prediction logic that always returns 1
        
        :param tasks: Label Studio tasks in JSON format
        :param context: Label Studio context in JSON format
        :return predictions: Predictions array in JSON format
        """
        predictions = []
        
        # Simple dummy response
        for task in tasks:
            predictions.append({
                'result': [],
                'score': 1.0,
                'model_version': self.get('model_version'),
            })

        return predictions

    def fit(self, event, data, **kwargs):
        """
        Handle annotation events (no-op for dummy model)
        
        :param event: Event type (ANNOTATION_CREATED, ANNOTATION_UPDATED, etc.)
        :param data: Event data
        """
        logger.debug(f'Fit called with event: {event}')
        # Dummy model doesn't need training
        pass

