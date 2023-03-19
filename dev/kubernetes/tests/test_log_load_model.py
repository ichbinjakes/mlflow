import os
from unittest import mock

import mlflow
import pytest
import sklearn.datasets
import sklearn.neighbors
from mlflow.models.signature import ModelSignature
from mlflow.types.schema import Schema, ColSpec


@pytest.fixture(scope="module")
def model():
    iris = sklearn.datasets.load_iris()
    x = iris.data[:, :2]
    y = iris.target
    knn_model = sklearn.neighbors.KNeighborsClassifier()
    knn_model.fit(x, y)
    return knn_model


@pytest.fixture(scope="module")
def model_signature():
    return ModelSignature(
        inputs=Schema([ColSpec("integer", "x"), ColSpec("integer", "y")]),
        outputs=Schema([ColSpec(name=None, type="double")]),
    )


@pytest.fixture(scope="module")
def config():
    return {
        "MLFLOW_TRACKING_URI": "http://localhost:32002",
        "MLFLOW_S3_ENDPOINT_URL": "http://localhost:32000",
        "AWS_ACCESS_KEY_ID": "mlflow",
        "AWS_SECRET_ACCESS_KEY": "mlflow123",
    }


def test_kubernetes_tracking_server(model, model_signature, config):

    with mock.patch.dict(os.environ, config):
        experiment = mlflow.get_experiment_by_name("test")
        if experiment:
            experiment_id = experiment.experiment_id
        else:
            experiment_id = mlflow.create_experiment("test")

        with mlflow.start_run(experiment_id=experiment_id) as run:
            mlflow.sklearn.log_model(
                sk_model=model, 
                artifact_path="model",
                signature=model_signature,
                registered_model_name="test-model",
                pip_requirements=['sklearn'],
            )
        
        loaded_model = mlflow.pyfunc.load_model('models:/test-model/None')
